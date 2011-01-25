class Errata
  class Erratum
    class Reject < Erratum
      def correct!
        raise "rejections don't correct"
      end
    end
  end
end
