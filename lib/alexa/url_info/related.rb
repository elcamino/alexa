module Alexa
  class UrlInfo
    class Related
      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}

        if !xml_node.nil?

          @data[:data_url] = xml_node.xpath('DataUrl').text.strip
          @data[:links]    = []

          xml_node.xpath('RelatedLinks/RelatedLink').each do |l|
            @data[:links] << {
              :data_url => l.xpath('DataUrl').text.strip,
              :navigable_url => l.xpath('NavigableUrl').text.strip,
              :title => l.xpath('Title').text.strip,
            }
          end
        end

      end
    end
  end
end

