require 'klaviyo/version'
require 'klaviyo/client'
require 'klaviyo/templates'
require 'klaviyo/lists'
require 'klaviyo/event'
require 'klaviyo/people'

require 'active_support'
require 'active_support/core_ext'
require 'faraday'
require 'faraday_middleware'
require 'json'
require 'virtus'


module Klaviyo
  DEFAULT_CA_BUNDLE_PATH = File.dirname(__FILE__) + '/data'
end
