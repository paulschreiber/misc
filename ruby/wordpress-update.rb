#!/usr/bin/ruby

## WordPress plugin updater
##
## Paul Schreiber <paulschreiber at gmail dot com>
## http://paulschreiber.com/
## release 10 January 2016
##
## Licensed under the MIT license
##
##

# Place this in your wp-content/ folder

def update(slug)
	url = "https://api.wordpress.org/plugins/info/1.0/#{slug}.json?fields=-compatibility,-sections,-tags,-ratings,-short_description"
	response = HTTParty.get(url, request: :json)

	unless response['version']
		puts "Could not find data for #{slug}"
		return
	end

	version = response['version']
	download_url = response['download_link']
	zipfile = Dir.tmpdir + '/' + download_url.split('/')[-1]

	FileUtils.rm_rf(slug)

	begin
		File.open(zipfile, 'wb') { |f| f.write HTTParty.get(download_url).parsed_response }
		`unzip -qq #{zipfile}`
	rescue
		puts "Could not update #{slug} to #{version}; reverting"
	end
end

require 'fileutils'
require 'httparty'
require 'tmpdir'

Dir.chdir('plugins')

plugins = Dir['*'] if plugins.empty?

plugins.each do |plugin|
	next if plugin[-4..-1] == '.php'

	puts "Updating #{plugin}..."
	update(plugin)
end
