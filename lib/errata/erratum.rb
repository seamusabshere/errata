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
    
    def correct!(row, &blk)
      return :skipped unless targets? row
      yield if block_given?
      :corrected
    end

    def expression_matches?(row)
      return true if matching_expression.blank? or section.blank?
      if matching_expression.is_a? ::Regexp
        matching_expression.match row[section].to_s
      else
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
      elsif options['x'].start_with? '/'
        if options['x'].end_with? 'i'
          ci = true
          expr = options['x'].chop
        else
          ci = false
          expr = options['x'].dup
        end
        expr.gsub! /\A\/|\/\z/, ''
        ::Regexp.new expr, ci
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
