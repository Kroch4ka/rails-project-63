# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Realize form generator
module HexletCode
  class Error < StandardError; end

  # Build HTML tag with params
  class Tag
    SINGLE = %w[img input br area base meta source].freeze
    DOUBLE = %w[div form p textarea label].freeze

    private_constant :SINGLE, :DOUBLE

    def self.build(name, params = {})
      raise 'I dont know this tag' unless SINGLE.include?(name) || DOUBLE.include?(name)
      raise 'Is not hash!' unless params.instance_of?(Hash)

      return process_single_tags(name, params) if SINGLE.include? name
      return process_double_tags(name, params) { yield if block_given? } if DOUBLE.include? name
    end

    def self.process_params(params = {})
      return '' if params.empty?

      params.keys.map do |key|
        params[key] ? %(#{key}="#{params[key]}") : ''
      end.join(' ').prepend(' ')
    end

    def self.process_single_tags(name, params = {})
      %(<#{name}#{process_params(params)}>)
    end

    def self.process_double_tags(name, params = {})
      %(<#{name}#{process_params(params)}>#{yield if block_given?}</#{name}>)
    end
  end

  # Form rendering based on object called and methods called
  class FormBuilder
    DEFAULT_PARAMS = {
      form: {
        action: '#',
        method: 'post'
      }.freeze,
      input: {
        type: 'text'
      }.freeze,
      textarea: {
        cols: '20',
        rows: '40'
      }.freeze
    }.freeze

    EXCEPTED_PARAMS = [:as].freeze

    MAP_PARAMS = {
      url: :action
    }.freeze

    private_constant :EXCEPTED_PARAMS, :DEFAULT_PARAMS

    def initialize(entity)
      @entity = entity
      @inner_elements = []
      yield(self) if block_given?
    end

    def build(params = {})
      params = set_default_params(params, DEFAULT_PARAMS[:form])

      Tag.build('form', params) { @inner_elements.join }
    end

    def input(entity_field, params = {})
      tag_name = params[:as] || :input
      params[:name], params[:value] = parse_entity entity_field
      inner_elements << element_builder(:label, { for: params[:name] }) { params[:name] }
      inner_elements << element_builder(tag_name, params.except(*EXCEPTED_PARAMS))
    end

    def submit(text = 'Save', _params = {})
      inner_elements << element_builder(:submit, value: text, type: 'submit')
    end

    private

    def set_default_params(params, default_params)
      params = params.transform_keys { |key| MAP_PARAMS[key] || key }

      default_params.merge params
    end

    def parse_entity(field_name)
      [field_name.to_s, entity.public_send(field_name)]
    end

    def element_builder(tag_name, params = {}, &block)
      case tag_name
      when :text then Tag.build('textarea', set_default_params(params, DEFAULT_PARAMS[:textarea]))
      when :input then Tag.build('input', set_default_params(params, DEFAULT_PARAMS[:input]))
      when :submit then Tag.build('input', params)
      when :label then Tag.build('label', params) { block.call if block_given? }
      else
        raise 'unexpected tag name'
      end
    end

    attr_reader :entity, :inner_elements
  end

  def self.form_for(entity, params = {})
    FormBuilder.new(entity) { |f| yield(f) if block_given? }.build(params)
  end
end
