 module Alexa
  class UrlInfo
    class TrafficData
      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}

        if !xml_node.nil?
          @data[:data_url] = xml_node.xpath('DataUrl').text.strip
          @data[:rank] = xml_node.xpath('Rank').text.strip

          @data[:by_country] = []
          xml_node.xpath('RankByCountry/Country').each do |r|
            @data[:by_country] << {
              :country       => r['Code'],
              :rank          => r.xpath('Rank').text.strip,
              :page_views    => r.xpath('Contribution/PageViews').text.strip,
              :users         => r.xpath('Contribution/Users').text.strip,
            }
          end

          @data[:by_city] = []
          xml_node.xpath('RankByCity/City').each do |c|
            @data[:by_city] << {
              :code => c['Code'],
              :name => c['Name'],
              :rank => c.xpath('Rank').text.strip,
              :page_views => c.xpath('Contribution/PageViews').text.strip,
              :users => c.xpath('Contribution/Users').text.strip,
              :average_page_views => c.xpath('Contribution/PerUser/AveragePageViews').text.strip,
            }
          end

          @data[:usage] = []
        end

      end
    end
  end
end

