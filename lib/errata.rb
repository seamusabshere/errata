require 'active_support'
require 'active_support/version'
%w{
  active_support/core_ext/module/delegation
  active_support/core_ext/hash/keys
  active_support/core_ext/hash/slice
}.each do |active_support_3_requirement|
  require active_support_3_requirement
end if ActiveSupport::VERSION::MAJOR == 3
require 'remote_table'
require 'erratum'
require 'erratum/delete'
require 'erratum/reject'
require 'erratum/replace'
require 'erratum/simplify'
require 'erratum/transform'
require 'erratum/truncate'

class Errata
  ERRATUM_TYPES = %w{delete replace simplify transform truncate}

  attr_reader :options
  
  # Arguments
  # * <tt>:responder</tt> (required) - normally you pass this something like Guru.new, which should respond to questions like #is_a_bentley?. If you pass a string, it will be lazily constantized and a new object initialized from it; for example, 'Guru' will lead to 'Guru'.constantize.new.
  # * <tt>:table</tt> - takes something that acts like a RemoteTable
  # If and only if you don't pass <tt>:table</tt>, all other options will be passed to a new RemoteTable (for example, <tt>:url</tt>, etc.)
  def initialize(options = {})
    options.symbolize_keys!
    @options = options
  end
  
  def table
    @_table ||= if options[:table].present?
      options[:table]
    else
      RemoteTable.new options.except(:responder)
    end
  end
  
  def responder
    @_responder ||= (options[:responder].is_a?(String) ? options[:responder].constantize.new : options[:responder])
  end
  
  def rejects?(row)
    rejections.any? { |erratum| erratum.targets?(row) }
  end
  
  def correct!(row)
    corrections.each { |erratum| erratum.correct!(row) }
    nil
  end
    
  def rejections
    @_rejections ||= table.rows.map { |hash| hash.symbolize_keys!; ::Errata::Erratum::Reject.new(self, hash) if hash[:action] == 'reject' }.compact
  end
  
  def corrections
    @_corrections ||= table.rows.map { |hash| hash.symbolize_keys!; "::Errata::Erratum::#{hash[:action].camelcase}".constantize.new(self, hash) if ERRATUM_TYPES.include?(hash[:action]) }.compact
  end
end
