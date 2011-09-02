module Alexa
  class UrlInfo
    class ContentData
      include Alexa::Container

      attr_accessor :data

      def initialize(xml_node = nil)
        @data = {}

        if !xml_node.nil?
          @data[:data_url]         = xml_node.xpath('DataUrl').text.strip
          @data[:title]            = xml_node.xpath('SiteData/Title').text.strip
          @data[:description]      = xml_node.xpath('SiteData/Description').text.strip
          @data[:online_since]     = xml_node.xpath('SiteData/OnlineSince').text.strip
          @data[:median_load_time] = xml_node.xpath('Speed/MedianLoadTime').text.strip
          @data[:load_percentile]  = xml_node.xpath('Speed/Percentile').text.strip
          @data[:adult_content]    = xml_node.xpath('AdultContent').text.strip
          @data[:language]         = xml_node.xpath('Language/Locale').text.strip
          @data[:links_in_count]   = xml_node.xpath('LinksInCount').text.strip

          @data[:keywords]         = []
          xml_node.xpath('Keywords/Keyword').each do |kw|
            @data[:keywords] << kw.text.strip
          end

          @data[:owned_domains]    = []
          xml_node.xpath('OwnedDomains/OwnedDomain').each do |d|
            @data[:owned_domains] << {
              :domain => d.xpath('Domain').text.strip,
              :title => d.xpath('Title').text.strip
            }
          end
        end

      end

    end
  end
end

