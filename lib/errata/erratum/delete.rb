class Errata
  class Erratum
    class Delete < Erratum
      def backfill
        # otherwise abbr(X) will kill the characters before and after the match
        @backfill ||= /\Aabbr\((.*)\)\z/.match(options['x']) ? '\1\2' : ''
      end
            
      def correct!(row)
        super(row) do
          row[section].gsub! matching_expression, backfill
        end
      end
    end
  end
end
