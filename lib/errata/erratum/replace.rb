class Errata
  class Erratum
    class Replace < Erratum
      attr_reader :correction

      def initialize(responder, options = {})
        super
        @correction = if abbr?
          '\1' + options[:y].to_s + '\2'
        else
          options[:y].to_s
        end
      end

      def correct!(row)
        if targets? row
          if matching_expression.blank?
            row[section] = correction.dup
          else
            row[section].gsub! matching_expression, correction
          end
        end
      end
    end
  end
end
