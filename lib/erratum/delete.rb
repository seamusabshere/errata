class Errata
  class Erratum
    class Delete < Erratum
      attr_accessor :matching_expression, :backfill
      
      def initialize(errata, options = {})
        super
        set_matching_expression(options)
        # otherwise abbr(X) will kill the characters before and after the match
        @backfill = /\Aabbr\((.*)\)\z/.match(options[:x]) ? '\1\2' : ''
      end
      
      def inspect
        super + " matching_expression=#{matching_expression}>"
      end
      
      def correct!(row)
        super(row) do
          row[column].gsub!(matching_expression, backfill)
        end
      end
    end
  end
end
