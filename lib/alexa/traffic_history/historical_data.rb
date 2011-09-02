module Alexa
  class TrafficHistory
    class HistoricalData
      require 'alexa/container'

      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}

        if ! xml_node.nil?
          xml_node.xpath('Data').each do |d|
            day = d.xpath('Date').text.strip

            ddata = {}
            ddata[:date] = day
            ddata[:pageviews_permillion] = d.xpath('PageViews/PerMillion').text.strip
            ddata[:pageviews_peruser] = d.xpath('PageViews/PerUser').text.strip
            ddata[:rank] = d.xpath('Rank').text.strip
            ddata[:reach_permillion] = d.xpath('Reach/PerMillion').text.strip

            @data[day] = ddata
          end
        end

      end
    end
  end
end

