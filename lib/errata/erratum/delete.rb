class Errata
  class Erratum
    class Delete < Erratum
      attr_reader :backfill

      def initialize(responder, options = {})
        super
        # otherwise abbr(X) will kill the characters before and after the match
        @backfill = if abbr?
          '\1\2'
        else
          ''
        end
      end
            
      def correct!(row)
        if targets? row
          row[section].gsub! matching_expression, backfill
        end
      end
    end
  end
end
