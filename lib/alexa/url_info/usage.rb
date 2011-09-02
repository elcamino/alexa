module Alexa
  class UrlInfo
    class Usage
      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}

        if !xml_node.nil?
          xml_node.xpath('//UsageStatistic').each do |s|
            range_node = s.xpath('TimeRange').children.find_all { |c| c.name != 'text' }.first
            key = range_node.text.strip + ' ' + range_node.name.strip

            stats = {}
            stats[:rank_value] = s.xpath('Rank/Value').text.strip
            stats[:rank_delta] = s.xpath('Rank/Delta').text.strip
            stats[:reach_rank_value] = s.xpath('Reach/Rank/Value').text.strip
            stats[:reach_rank_delta] = s.xpath('Reach/Rank/Delta').text.strip
            stats[:reach_permillion_value] = s.xpath('Reach/PerMillion/Value').text.strip
            stats[:reach_permillion_delta] = s.xpath('Reach/PerMillion/Delta').text.strip
            stats[:pageviews_permillion_value] = s.xpath('PageViews/PerMillion/Value').text.strip
            stats[:pageviews_permillion_delta] = s.xpath('PageViews/PerMillion/Delta').text.strip
            stats[:pageviews_rank_value] = s.xpath('PageViews/Rank/Value').text.strip
            stats[:pageviews_rank_delta] = s.xpath('PageViews/Rank/Delta').text.strip
            stats[:pageviews_peruser_value] = s.xpath('PageViews/PerUser/Value').text.strip
            stats[:pageviews_peruser_delta] = s.xpath('PageViews/PerUser/Delta').text.strip

            @data[key] = stats
          end
        end
      end
    end
  end
end

