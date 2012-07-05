
module Alexa

  require 'nokogiri'
  require 'alexa/container'
  require 'alexa/url_info/contact_info'
  require 'alexa/url_info/content_data'
  require 'alexa/url_info/related'
  require 'alexa/url_info/categories'
  require 'alexa/url_info/traffic_data'
  require 'alexa/url_info/usage'
  require 'alexa/url_info/contributing_subdomains'

  class UrlInfo


    attr_reader :contact_info, :content_data, :related, :traffic_data, :usage, :contributing_subdomains, :categories

    def initialize(data = { })
      @options = {
        'Action'           => 'UrlInfo',
        'AWSAccessKeyId'   => Alexa.config.access_key_id,
        'Timestamp'        => Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
        'ResponseGroup'    => 'RelatedLinks,Categories,Rank,RankByCountry,RankByCity,UsageStats,ContactInfo,ContactInfo,AdultContent,Speed,Language,Keywords,OwnedDomains,LinksInCount,SiteData',
        'SignatureVersion' => 2,
        'SignatureMethod'  => 'HmacSHA256',
        'Version'          => '2005-07-11',
        'Url'              => nil,
      }

      if data['contact_info']
        @contact_info = data['contact_info']
      end

      if data['content_data']
        @content_data = data['content_data']
      end

      if data['related']
        @related = data['related']
      end

      if data['traffic_data']
        @traffic_data = data['traffic_data']
      end

      if data['usage']
        @usage = data['usage']
      end

      if data['contributing_subdomains']
        @contributing_subdomains = data['contributing_subdomains']
      end

      if data['categories']
        @categories = data['categories']
      end

      if Alexa.config.proxy
        RestClient.proxy = Alexa.config.proxy
      end
    end

    def signature
      Alexa.sign(@options)
    end

    def url
      qs = Alexa.query_string(@options)
      sign = signature
      'http://' + ::Alexa::SERVICE_HOST + '/?' + qs + '&Signature=' + sign
    end

    def fetch(options = {})
      @options.merge!(options)
      @options.delete_if { |k,v| v.nil? }

      response = RestClient.get(url)
      data = Nokogiri::XML(response.to_s)
      data.remove_namespaces!

      @contact_info            = ContactInfo.new(data.xpath('//ContactInfo').first)
      @content_data            = ContentData.new(data.xpath('//ContentData').first)
      @related                 = Related.new(data.xpath('//Related').first)
      @categories              = Categories.new(data.xpath('//Categories').first)
      @traffic_data            = TrafficData.new(data.xpath('//TrafficData').first)
      @usage                   = Usage.new(data.xpath('//UsageStatistics').first)
      @contributing_subdomains = ContributingSubdomains.new(data.xpath('//ContributingSubdomains').first)

      self
    end

    def self.to_mongo(value)
      return nil   if value.nil?
      return value if value.is_a? Hash

      return {
        'contact_info'            => ContactInfo.to_mongo(value.contact_info),
        'content_data'            => ContentData.to_mongo(value.content_data),
        'related'                 => Related.to_mongo(value.related),
        'categories'              => Categories.to_mongo(value.categories),
        'traffic_data'            => TrafficData.to_mongo(value.traffic_data),
        'usage'                   => Usage.to_mongo(value.usage),
        'contributing_subdomains' => ContributingSubdomains.to_mongo(value.contributing_subdomains),
      }
    end

    def self.from_mongo(value)
      return nil if value.nil?
      return value if value.is_a?(self)

      self.new(
               'contact_info'            => ContactInfo.from_mongo(value['contact_info']),
               'content_data'            => ContentData.from_mongo(value['content_data']),
               'related'                 => Related.from_mongo(value['related']),
               'categories'              => Categories.from_mongo(value['categories']),
               'traffic_data'            => TrafficData.from_mongo(value['traffic_data']),
               'usage'                   => Usage.from_mongo(value['usage']),
               'contributing_subdomains' => ContributingSubdomains.from_mongo(value['contributing_subdomains'])
               )
    end

    #
    # Exceptions
    #

    class ArgumentException < Exception
    end
  end


end
