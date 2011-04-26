require 'to_regexp'

class Errata
  class Erratum
    autoload :Delete, 'errata/erratum/delete'
    autoload :Reject, 'errata/erratum/reject'
    autoload :Replace, 'errata/erratum/replace'
    autoload :Simplify, 'errata/erratum/simplify'
    autoload :Transform, 'errata/erratum/transform'
    autoload :Truncate, 'errata/erratum/truncate'
    
    attr_reader :errata
    attr_reader :options
    
    def initialize(errata, options = {})
      @errata = errata
      @options = options.dup
    end
    
    def section
      options['section']
    end
    
    def responder
      errata.responder
    end
    
    def matching_methods
      @matching_methods ||= options['condition'].split(/\s*;\s*/).map do |method_id|
        "#{method_id.strip.gsub(/[^a-z0-9]/i, '_').downcase}?"
      end
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
        
    def matching_expression
      return @matching_expression[0] if @matching_expression.is_a? ::Array
      @matching_expression = []
      @matching_expression[0] = if options['x'].blank?
        nil
      elsif (options['x'].start_with?('/') or options['x'].start_with?('%r{')) and as_regexp = options['x'].as_regexp
        ::Regexp.new(*as_regexp)
      elsif /\Aabbr\((.*)\)\z/.match options['x']
        abbr = $1.split(/(\w\??)/).reject { |a| a == '' }.join('\.?\s?') + '\.?([^\w\.]|\z)'
        expr = '(\A|\s)' + abbr
        ::Regexp.new expr, true
      elsif %w{reject truncate}.include? options['action']
        expr = '\A\s*' + ::Regexp.escape(options['x'])
        ::Regexp.new expr, true
      else
        options['x']
      end
      @matching_expression[0]
    end
  end
end
