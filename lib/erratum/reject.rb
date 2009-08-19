class Errata
  class Erratum
    class Reject < Erratum
      attr_accessor :matching_expression
      
      def initialize(errata, options = {})
        super
        set_matching_expression(options.merge(:prefix => true))
      end
      
      def inspect
        super + " matching_expression=#{matching_expression}"
      end
      
      def correct!
        raise "rejections don't correct"
      end
    end
  end
end
