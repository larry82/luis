require 'luis/version'
require 'httparty'
# Luis Module
module Luis
  autoload :Base, 'luis/base'
  autoload :Result, 'luis/result'
  autoload :Intent, 'luis/intent'
  autoload :Action, 'luis/action'
  autoload :Parameter, 'luis/parameter'
  autoload :Dialog, 'luis/dialog'
  autoload :Entity, 'luis/entity'
  autoload :CompositeEntity, 'luis/composite_entity'
  autoload :CompositeEntityChild, 'luis/composite_entity_child'

  include HTTParty
  class << self
   attr_accessor :id, :subscription_key, :is_preview_mod, :is_verbose, :is_staging, :timezoneOffset
  end

  def self.api_uri
    uri = "https://westus.api.cognitive.microsoft.com/luis/v2.0/apps/#{id}"
  end

  # Query method for the luis
  #
  # @param [String,#read] query text
  # @param [Luis::Result] Luis result object
  def self.query(query, context_id = nil)
    options = default_options
    options['q'] = query
    options['contextId'] = context_id if context_id
    puts "api_url=#{api_uri}, options=#{options}"
    response = get(api_uri, query: options)
    Result.new JSON.parse(response.body)
  end

  # Configure luis credentials and settings
  #
  # @param [options] contains list of options to set
  def self.configure(options = {})
    options.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
    yield(self) if block_given?
  end

  def self.default_options
    options = { 'subscription-key' => subscription_key }
    options['verbose'] = is_verbose || true
    options['staging'] = is_staging || true
    options['timezoneOffset'] = timezoneOffset || 0
    
    options
  end
end
