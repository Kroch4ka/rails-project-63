# frozen_string_literal: true

require_relative "hexlet_code/version"

# Realize form generator
module HexletCode
  class Error < StandardError; end

  # Build HTML tag with params
  class Tag
    SINGLE = %w[img input br area base meta source].freeze
    DOUBLE = %w[div form p].freeze

    private_constant :SINGLE, :DOUBLE

    def self.build(name, params = {})
      raise "I dont know this tag" unless SINGLE.include?(name) || DOUBLE.include?(name)
      return process_single_tags(name, params) if SINGLE.include? name
      return process_double_tags(name, params) if DOUBLE.include? name
    end

    def self.process_params(params = {})
      params.keys.map do |key|
        %(#{key}="#{params[key]}")
      end.join(" ")
    end

    def self.process_single_tags(name, params = {})
      %(<#{name} #{process_params(params)}>)
    end

    def self.process_double_tags(name, params = {})
      %(<#{name} #{process_params(params)}>#{yield if block_given?}</#{name}>)
    end
  end

  def self.form_for(_entity, url: nil)
    raise RuntimeError unless sblock_given?

    Tag.build("form", action: url || "#", method: "post")
  end
end
