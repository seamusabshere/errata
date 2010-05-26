class Errata
  class Erratum
    attr_accessor :errata, :column, :options
    delegate :responder, :to => :errata
    
    def initialize(errata, options = {})
      raise "you can't set this from outside" if options[:prefix].present?
      @errata = errata
      @column = options[:section]
      @options = options
    end
    
    def matching_methods
      @_matching_methods ||= options[:condition].split(/\s*;\s*/).map do |method_id|
        "#{method_id.strip.gsub(/[^a-z0-9]/i, '_').downcase}?"
      end
    end
    
    def inspect
      "<#{self.class.name}:#{object_id} responder=#{responder.to_s} column=#{column} matching_methods=#{matching_methods.inspect}"
    end
    
    def targets?(row)
      !!(conditions_match?(row) and expression_matches?(row))
    end
    
    def correct!(row, &block)
      return :skipped unless targets?(row)
      # old_value = row[column].to_s.dup
      yield if block_given?
      # unless name.demodulize.underscore == 'truncate' or name.demodulize.underscore == 'simplify'
      #   puts "-" * 64
      #   puts inspect
      #   puts row.inspect
      #   if row[column] != old_value
      #     puts "#{old_value} -> #{row[column]}"
      #   else
      #     puts "no change"
      #   end
      #   puts
      # end
      :corrected
    end

    def expression_matches?(row)
      return true if matching_expression.blank? or column.blank?
      if matching_expression.is_a?(Regexp)
        matching_expression.match(row[column].to_s)
      else
        row[column].to_s.include?(matching_expression)
      end
    end
    
    def conditions_match?(row)
      matching_methods.all? { |method_id| responder.send method_id, row }
    end
    
    def set_matching_expression(options = {})
      if options[:x].blank?
        @matching_expression = nil
      elsif options[:x].start_with?('/')
        if options[:x].end_with?('i')
          ci = true
          options[:x] = options[:x].chop
        else
          ci = false
        end
        @matching_expression = Regexp.new(options[:x].gsub(/\A\/|\/\z/, ''), ci)
      elsif /\Aabbr\((.*)\)\z/.match(options[:x])
        @matching_expression = Regexp.new('(\A|\s)' + $1.split(/(\w\??)/).reject { |a| a == '' }.join('\.?\s?') + '\.?([^\w\.]|\z)', true)
      elsif options[:prefix] == true
        @matching_expression = Regexp.new('\A\s*' + Regexp.escape(options[:x]), true)
      else
        @matching_expression = options[:x]
      end
    end
  end
end
