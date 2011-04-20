class Errata
  class Erratum
    class Transform < Erratum
      ALLOWED_METHODS = %w{upcase downcase}

      def string_method
        raise %{string method "#{options['y']}" not allowed} unless ALLOWED_METHODS.include? options['y']
        options['y']
      end
      
      def correct!(row)
        if targets? row
          row[section].gsub!(matching_expression) { |match| match.send string_method }
        end
      end
    end
  end
end
