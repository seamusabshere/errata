class Errata
  class Erratum
    class Replace < Erratum
      attr_accessor :matching_expression, :correction
      
      def initialize(errata, options = {})
        super
        set_matching_expression(options)
        @correction = /\Aabbr\((.*)\)\z/.match(options[:x]) ? '\1' + options[:y].to_s + '\2' : options[:y].to_s
      end
      
      def inspect
        super + " matching_expression=#{matching_expression} correction=#{correction}>"
      end
      
      def correct!(row)
        super(row) do
          if matching_expression.blank?
            row[column] = correction
          else
            row[column].gsub!(matching_expression, correction)
          end
        end
      end
    end
  end
end
