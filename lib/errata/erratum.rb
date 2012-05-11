require 'to_regexp'

require 'errata/erratum/delete'
require 'errata/erratum/reject'
require 'errata/erratum/replace'
require 'errata/erratum/simplify'
require 'errata/erratum/transform'
require 'errata/erratum/truncate'

class Errata
  class Erratum
    SEMICOLON_DELIMITER = /\s*;\s*/
    SPECIAL_ABBR = /\Aabbr\((.*)\)\z/
    REJECT_ACTIONS = %w{reject truncate}

    attr_reader :responder
    attr_reader :section
    attr_reader :matching_methods
    attr_reader :matching_expression
    
    def initialize(responder, options = {})
      @responder = responder
      @section = options[:section]
      @matching_methods = options[:condition].split(SEMICOLON_DELIMITER).map do |method_id|
        method_id.strip.gsub(/\W/, '_').downcase + '?'
      end
      if @matching_methods.any? and @responder.nil?
        raise ::ArgumentError, %{[errata] Conditions like #{@matching_methods.first.inspect} used, but no :responder defined}
      end
      @matching_expression = if options[:x].blank?
        nil
      elsif (options[:x].start_with?('/') or options[:x].start_with?('%r{')) and as_regexp = options[:x].as_regexp
        ::Regexp.new(*as_regexp)
      elsif SPECIAL_ABBR.match options[:x]
        @abbr_query = true
        abbr = $1.split(/(\w\??)/).reject { |a| a == '' }.join('\.?\s?') + '\.?([^\w\.]|\z)'
        expr = '(\A|\s)' + abbr
        ::Regexp.new expr, true
      elsif REJECT_ACTIONS.include? options[:action]
        expr = '\A\s*' + ::Regexp.escape(options[:x])
        ::Regexp.new expr, true
      else
        options[:x]
      end
    end

    def abbr?
      @abbr_query == true
    end
    
    def targets?(row)
      !!(conditions_match?(row) and expression_matches?(row))
    end
    
    def expression_matches?(row)
      return true if matching_expression.blank? or section.blank?
      case matching_expression
      when ::Regexp
        matching_expression.match row[section].to_s
      when ::String
        row[section].to_s.include? matching_expression
      end
    end
    
    def conditions_match?(row)
      matching_methods.all? { |method_id| responder.send method_id, row }
    end
  end
end
