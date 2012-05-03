class Errata
  class Erratum
    class Simplify < Erratum
      attr_reader :second_section

      def initialize(responder, options = {})
        super
        @second_section = options[:x]
      end

      def targets?(row)
        !row[section].blank? and !row[second_section].blank? and conditions_match?(row) and special_matcher(row).match(row[section])
      end
      
      def correct!(row)
        if targets? row
          row[section].gsub! special_matcher(row), ''
        end
      end
      
      private

      def special_matcher(row)
        /[\s\(\[\'\"]*#{::Regexp.escape(row[second_section])}[\s\)\]\'\"]*/
      end
    end
  end
end
