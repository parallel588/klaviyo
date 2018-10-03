require 'klaviyo/version'

require 'active_support'
require 'active_support/core_ext'
require 'faraday'
require 'multi_json'
require 'json'
require 'virtus'

require 'klaviyo/client'
require 'klaviyo/errors'
require 'klaviyo/resource'
require 'klaviyo/templates'
require 'klaviyo/lists'
require 'klaviyo/event'
require 'klaviyo/people'



module Klaviyo
  DEFAULT_CA_BUNDLE_PATH = File.dirname(__FILE__) + '/data'
end
