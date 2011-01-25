class Errata
  class Erratum
    class Simplify < Erratum
      def second_section
        options['x']
      end

      def targets?(row)
        !row[section].blank? and !row[second_section].blank? and conditions_match?(row) and special_matcher(row).match(row[section])
      end
      
      def correct!(row)
        super(row) do
          row[section].gsub! special_matcher(row), ''
        end
      end
      
      def special_matcher(row)
        /[\s\(\[\'\"]*#{::Regexp.escape(row[second_section])}[\s\)\]\'\"]*/
      end
    end
  end
end
