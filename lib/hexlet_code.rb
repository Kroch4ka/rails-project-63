# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  class Tag
    SINGLE = ['img', 'input', 'br', 'area', 'base', 'meta', 'source']
    DOUBLE = ['div', 'form', 'p']

    private_constant :SINGLE, :DOUBLE

    def self.build(name, params = {})
      raise "I dont know this tag" unless SINGLE.include? name or DOUBLE.include? name
      return process_single_tags(name, params) if SINGLE.include? name
      return process_double_tags(name, params) if DOUBLE.include? name
    end

    private

    def self.process_params(params = {})
      params.keys.map do |key|
        %(#{key}="#{params[key]}")
      end.join(' ')
    end

    def self.process_single_tags(name, params = {})
      %(<#{name} #{process_params(params)}>)
    end

    def self.process_double_tags(name, params = {})
      %(<#{name} #{process_params(params)}>#{yield if block_given?}</#{name}>)
    end
  end
end