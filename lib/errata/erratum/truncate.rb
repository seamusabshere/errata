class Errata
  class Erratum
    class Truncate < Erratum
      def necessary_and_sufficient_prefix
        options['x']
      end

      def correct!(row)
        if targets? row
          row[section] = necessary_and_sufficient_prefix.dup
        end
      end
    end
  end
end
