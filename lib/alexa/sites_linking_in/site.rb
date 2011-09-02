module Alexa
  class SitesLinkingIn
    class Site
      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}

        if ! xml_node.nil?
          @data[:title] = xml_node.xpath('Title').text.strip
          @data[:url] = xml_node.xpath('Url').text.strip
        end
      end

    end
  end
end
