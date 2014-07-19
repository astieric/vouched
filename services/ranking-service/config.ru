require 'rubygems'
require 'bundler'

Bundler.require(:service)

require File.expand_path("../service", __FILE__)
#require_relative 'service'

run Service.new