require 'thread'

require 'active_support'
require 'active_support/version'
if ::ActiveSupport::VERSION::MAJOR >= 3
  require 'active_support/core_ext'
end
require 'remote_table'

require 'errata/erratum'

class Errata
  CORRECTIONS = %w{delete replace simplify transform truncate reject}

  attr_reader :lazy_load_table_options
  attr_reader :lazy_load_responder_class_name

  # Arguments
  # * <tt>:responder</tt> (required) - normally you pass this something like Guru.new, which should respond to questions like #is_a_bentley?. If you pass a string, it will be lazily constantized and a new object initialized from it; for example, 'Guru' will lead to 'Guru'.constantize.new.
  # * <tt>:table</tt> - takes something that acts like a RemoteTable
  # If and only if you don't pass <tt>:table</tt>, all other options will be passed to a new RemoteTable (for example, <tt>:url</tt>, etc.)
  def initialize(options = {})
    options = options.symbolize_keys

    responder = options.delete :responder
    if responder.is_a?(::String)
      @lazy_load_responder_mutex = ::Mutex.new
      @lazy_load_responder_class_name = responder
    elsif responder
      ::Kernel.warn %{[errata] Passing an object as :responder is deprecated. It's recommended to pass a class name instead, which will be constantized and instantiated with no arguments.}
      @responder = responder
    else
      @no_responder = true
    end

    if table = options.delete(:table)
      ::Kernel.warn %{[errata] Passing :table is deprecated. It's recommended to pass table options instead.}
      @table = table
    else
      @lazy_load_table_options = options
    end

    @set_rejections_and_corrections_mutex = ::Mutex.new
  end
    
  def rejects?(row)
    rejections.any? { |erratum| erratum.targets?(row) }
  end
  
  def correct!(row)
    corrections.each { |erratum| erratum.correct!(row) }
    nil
  end

  def responder
    return if @no_responder == true
    @responder || @lazy_load_responder_mutex.synchronize do
      @responder ||= lazy_load_responder_class_name.constantize.new
    end
  end

  private

  def set_rejections_and_corrections!
    return if @set_rejections_and_corrections == true
    @set_rejections_and_corrections_mutex.synchronize do
      return if @set_rejections_and_corrections == true

      if @table
        table = @table
        @table = nil # won't need this again
      else
        table = ::RemoteTable.new lazy_load_table_options
      end

      rejections = []
      corrections = []

      table.each do |erratum_initializer|
        erratum_initializer = erratum_initializer.symbolize_keys
        action = erratum_initializer[:action].downcase
        if action == 'reject'
          rejections << Erratum::Reject.new(responder, erratum_initializer)
        elsif CORRECTIONS.include?(action)
          corrections << Erratum.const_get(action.camelcase).new(responder, erratum_initializer)
        end
      end

      @rejections = rejections
      @corrections = corrections
      @set_rejections_and_corrections = true
    end
  end
  
  def rejections
    set_rejections_and_corrections!
    @rejections
  end
  
  def corrections
    set_rejections_and_corrections!
    @corrections
  end
end
