module Alexa
  module Container

    attr_accessor :data

    def keys
      @data.keys
    end

    def to_mongo
      self.class.to_mongo(self)
    end

    def method_missing(name)
      myname = ActiveSupport::Inflector.underscore(name).to_sym
      raise Exception.new("there is no data field called \"#{name}\" here!") unless @data.has_key?(myname) || @data.has_key?(myname.to_s)

      if @data.has_key?(myname)
        return @data[myname]
      end

      if @data.has_key?(myname.to_s)
        return @data[myname.to_s]
      end

    end

    module ClassMethods

      def to_mongo(value)
        return nil if value.nil?
        return value if value.is_a?(Hash)

        value.data
      end

      def from_mongo(value)
        return nil if value.nil?
        return value if value.is_a?(self)

        o = self.new
        o.data = value

        return o
      end
    end


    def self.included(base)
      base.extend(ClassMethods)
    end

  end
end
