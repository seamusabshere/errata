require 'active_support'
require 'active_support/version'
%w{
  active_support/core_ext/hash/keys
  active_support/core_ext/hash/slice
}.each do |active_support_3_requirement|
  require active_support_3_requirement
end if ::ActiveSupport::VERSION::MAJOR == 3
require 'remote_table'

class Errata
  autoload :Erratum, 'errata/erratum'
  
  ERRATUM_TYPES = %w{delete replace simplify transform truncate reject}

  attr_reader :options
  
  # Arguments
  # * <tt>'responder'</tt> (required) - normally you pass this something like Guru.new, which should respond to questions like #is_a_bentley?. If you pass a string, it will be lazily constantized and a new object initialized from it; for example, 'Guru' will lead to 'Guru'.constantize.new.
  # * <tt>'table'</tt> - takes something that acts like a RemoteTable
  # If and only if you don't pass <tt>'table'</tt>, all other options will be passed to a new RemoteTable (for example, <tt>'url'</tt>, etc.)
  def initialize(options = {})
    @options = options.dup
    @options.stringify_keys!
  end
  
  def responder
    options['responder'].is_a?(::String) ? options['responder'].constantize.new : options['responder']
  end
  
  def rejects?(row)
    rejections.any? { |erratum| erratum.targets?(row) }
  end
  
  def correct!(row)
    corrections.each { |erratum| erratum.correct!(row) }
    nil
  end
  
  def errata
    return @errata if @errata.is_a? ::Array
    (options['table'] ? options['table'] : ::RemoteTable.new(options.except('responder'))).map do |erratum_description|
      next unless ERRATUM_TYPES.include? erratum_description['action']
      "::Errata::Erratum::#{erratum_description['action'].camelcase}".constantize.new self, erratum_description
    end.compact
  end
  
  def rejections
    errata.select { |erratum| erratum.is_a? ::Errata::Erratum::Reject }
  end
  
  def corrections
    errata.select { |erratum| not erratum.is_a? ::Errata::Erratum::Reject }
  end
end
