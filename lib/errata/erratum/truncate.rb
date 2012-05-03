class Errata
  class Erratum
    class Truncate < Erratum
      attr_reader :necessary_and_sufficient_prefix

      def initialize(responder, options = {})
        super
        @necessary_and_sufficient_prefix = options[:x]
      end

      def correct!(row)
        if targets? row
          row[section] = necessary_and_sufficient_prefix.dup
        end
      end
    end
  end
end
