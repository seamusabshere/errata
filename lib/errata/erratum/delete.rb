class Errata
  class Erratum
    class Delete < Erratum
      def backfill
        # otherwise abbr(X) will kill the characters before and after the match
        @backfill ||= /\Aabbr\((.*)\)\z/.match(options['x']) ? '\1\2' : ''
      end
            
      def correct!(row)
        if targets? row
          row[section].gsub! matching_expression, backfill
        end
      end
    end
  end
end
