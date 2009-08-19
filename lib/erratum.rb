class Errata
  class Erratum
    attr_accessor :errata, :column, :matching_method
    delegate :klass, :to => :errata
    
    def initialize(errata, options = {})
      raise "you can't set this from outside" if options.has_key?(:prefix)
      @errata = errata
      @column = options[:section]
      @matching_method = "#{options[:condition].gsub(/[^a-z0-9]/i, '_').downcase}?".to_sym if options[:condition]
    end
    
    def inspect
      "<#{self.class.name}:#{object_id} klass=#{klass.name} column=#{column} matching_method=#{matching_method}"
    end
    
    def targets?(row)
      !!(method_matches?(row) and expression_matches?(row))
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

    private
    
    def expression_matches?(row)
      return true if matching_expression.blank? or column.blank?
      if matching_expression.is_a?(Regexp)
        matching_expression.match(row[column].to_s)
      else
        row[column].to_s.include?(matching_expression)
      end
    end
    
    def method_matches?(row)
      return true if matching_method.nil?
      klass.send(matching_method, row)
    end
    
    def set_matching_expression(options = {})
      if options[:x].blank?
        @matching_expression = nil
      elsif options[:x].starts_with?('/')
        if options[:x].ends_with?('i')
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
