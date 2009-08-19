class Errata
  class Erratum
    class Transform < Erratum
      ALLOWED_METHODS = %w{upcase downcase}
      attr_accessor :matching_expression, :string_method
      
      def initialize(errata, options = {})
        super
        set_matching_expression(options)
        @string_method = options[:y]
        raise "string method (#{@string_method}) needs to be in (#{ALLOWED_METHODS.join(', ')})" unless ALLOWED_METHODS.include?(@string_method)
      end
      
      def inspect
        super + " matching_expression=#{matching_expression} string_method=#{string_method}>"
      end
      
      def correct!(row)
        super(row) do
          row[column].gsub!(matching_expression) { |match| match.send(string_method) }
        end
      end
    end
  end
end
