require 'unitwise/standard/extras'
module Unitwise::Standard
  class Base
    include Unitwise::Standard::Extras

    attr_accessor :attributes

    def self.local_key
      remote_key
    end

    def self.all
      @all ||= read
    end

    def self.read
      Unitwise::Standard.hash[remote_key].inject([]){|a,h| a << self.new(h)}
    end

    def self.hash
      self.all.map(&:to_hash)
    end

    def self.path
      File.join Unitwise.data_path, "#{self.local_key}.yaml"
    end

    def self.write
      File.open(path, 'w') do |f|
        f.write hash.to_yaml
      end
    end

    def initialize(attributes)
      @attributes = attributes
    end

    def names
      if attributes["name"].respond_to?(:map)
        attributes["name"].map(&:to_s)
      else
        attributes["name"].to_s
      end
    end

    def symbol
      if attributes["printSymbol"].is_a?(Hash)
        hash_to_markup(attributes["printSymbol"])
      else
        attributes["printSymbol"].to_s
      end
    end

    def primary_code
      attributes["@Code"]
    end

    def secondary_code
      attributes["@CODE"]
    end

    def to_hash
      { names: names, symbol: symbol,
        primary_code: primary_code, secondary_code: secondary_code}
    end

  end
end