#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'net/https'
require 'json'
require 'simple_oauth'
require 'yaml'
#require 'ruby-debug'
require 'optparse'

########################################################

dir = File.expand_path(File.dirname(__FILE__))

require File.join(dir, "./utility")
require File.join(dir, "./commandparser")
require File.join(dir, "./api")

base_args, command_args = Utility.split_args(ARGV)

# Parse command options
command_parser = CommandParser.new(base_args, command_args)
base_options, command_options = command_parser.parse!


#debugger
oauth_file = base_options[:oauth_file] || (ENV['HOME'] + "/oauth_credentials.yml")
$stderr << "Using oauth file #{oauth_file}\n"
api = TwitterApi.new(oauth_file)
ids = command_options[:user_ids]
api.lookup(ids)

########################################################
