class Errata
  class Erratum
    class Simplify < Erratum
      attr_accessor :second_column
      
      def initialize(errata, options = {})
        super
        @second_column = options[:x]
      end

      def inspect
        super + " second_column=#{second_column}>"
      end
      
      def targets?(row)
        !row[column].blank? and !row[second_column].blank? and method_matches?(row) and matching_expression(row).match(row[column])
      end
      
      def correct!(row)
        super(row) do
          row[column].gsub!(matching_expression(row), '')
        end
      end
      
      private
      
      def matching_expression(row)
        @_matching_expressions ||= {}
        @_matching_expressions[row[second_column]] ||= /[\s\(\[\'\"]*#{Regexp.escape(row[second_column])}[\s\)\]\'\"]*/
      end
    end
  end
end
