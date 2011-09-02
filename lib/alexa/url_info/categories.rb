module Alexa
  class UrlInfo
    class Categories
      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}
        @data[:categories] = []

        if xml_node != nil
          xml_node.xpath('CategoryData').each do |c|
            @data[:categories] << {
              :title         => c.xpath('Title').text.strip,
              :absolute_path => c.xpath('AbsolutePath').text.strip,
            }
          end
        end

      end
    end
  end
end

