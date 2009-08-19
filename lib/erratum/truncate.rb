class Errata
  class Erratum
    class Truncate < Erratum
      attr_accessor :matching_expression, :necessary_and_sufficient_prefix
      
      def initialize(errata, options = {})
        super
        @necessary_and_sufficient_prefix = options[:x]
        raise "necessary_and_sufficient_prefix cannot be blank" if @necessary_and_sufficient_prefix.blank?
        set_matching_expression(options.merge(:prefix => true))
      end

      def inspect
        super + " matching_expression=#{matching_expression} necessary_and_sufficient_prefix=#{necessary_and_sufficient_prefix}>"
      end
      
      def correct!(row)
        super(row) do
          row[column] = necessary_and_sufficient_prefix
        end
      end
    end
  end
end
