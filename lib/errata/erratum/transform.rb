class Errata
  class Erratum
    class Transform < Erratum
      ALLOWED_METHODS = %w{upcase downcase}

      attr_reader :string_method

      def initialize(responder, options = {})
        super
        @string_method = options[:y]
        raise %{[errata] Method "#{@string_method}" not allowed} unless ALLOWED_METHODS.include? @string_method
      end

      def correct!(row)
        if targets? row
          row[section].gsub!(matching_expression) { |match| match.send string_method }
        end
      end
    end
  end
end
