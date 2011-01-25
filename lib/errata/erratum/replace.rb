class Errata
  class Erratum
    class Replace < Erratum
      def correction
        @correction ||= /\Aabbr\((.*)\)\z/.match(options['x']) ? '\1' + options['y'].to_s + '\2' : options['y'].to_s
      end

      def correct!(row)
        super(row) do
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
