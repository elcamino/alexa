module Alexa
  class UrlInfo
    class ContactInfo
      include Alexa::Container

      def initialize(xml_node = nil)
        @data = {}

        if ! xml_node.nil?
          @data[:data_url] = xml_node.xpath('DataUrl').text.strip
          @data[:phone_numbers] = []
          xml_node.xpath('PhoneNumbers/PhoneNumber').each do |p|
            @data[:phone_numbers] << p.text.strip
          end
          @data[:owner_name] = xml_node.xpath('OwnerName').text.strip
          @data[:email] = xml_node.xpath('Email').text.strip
          @data[:streets] = []
          xml_node.xpath('PhysicalAddress/Streets/Street').each do |s|
            @data[:streets] << s.text.strip
          end
          @data[:city] = xml_node.xpath('PhysicalAddress/City').text.strip
          @data[:state] = xml_node.xpath('PhysicalAddress/State').text.strip
          @data[:postal_code] = xml_node.xpath('PhysicalAddress/PostalCode').text.strip
          @data[:country] = xml_node.xpath('PhysicalAddress/Country').text.strip
          @data[:stock_symbol] = xml_node.xpath('CompanyStockTicker/Symbol').text.strip
        end
      end

    end
  end
end

