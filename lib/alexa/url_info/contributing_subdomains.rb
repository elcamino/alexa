module Alexa
  class UrlInfo
    class ContributingSubdomains
      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}

        if !xml_node.nil?
          xml_node.xpath('ContributingSubdomain').each do |cs|
            range_node = cs.xpath('TimeRange').children.find_all { |c| c.name != 'text' }.first

            domain = cs.xpath('DataUrl').text.strip

            ddata = {}

            ddata[:data_url] = domain
            ddata[:range] = range_node.text.strip + ' ' + range_node.name.strip
            ddata[:reach_percentage] = cs.xpath('Reach/Percentage').text.strip
            ddata[:pageviews_percentage] = cs.xpath('PageViews/Percentage').text.strip
            ddata[:pageviews_peruser] = cs.xpath('PageViews/PerUser').text.strip

            @data[domain] = ddata
          end
        end

      end
    end
  end
end

