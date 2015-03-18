#!/usr/bin/ruby -w

#
# tinypng.rb — Placed into the public domain by Daniel Reese.
# http://www.danandcheryl.com/tag/tinypng
#
# Updated by Paul Schreiber (2015-03-18)
#

require 'rubygems'
require 'json'

# Set API key.
apikey = "YOUR_API_KEY_HERE"

# Verify arguments.
ARGV.length == 2 or fail("Usage: ./tinypng.rb <input-folder> <output-folder>")
src = ARGV[0]
dst = ARGV[1]
File.exist?(src) or fail("Input folder does not exist: " + src)
File.exist?(dst) or fail("Output folder does not exist: " + dst)

# Optimize each image in the source folder.
Dir.chdir(src)
Dir.glob('*.{png,jpg}') do |png_file|
	if File.exist?("#{dst}/#{png_file}")
		puts "Skipping (already compressed) #{dst}/#{png_file}"
		next
	end

	if File.zero?(png_file)
		puts "Skipping (empty file) #{png_file}"
		next
	end

	puts "\nOptimizing #{png_file}"

	# Optimize and deflate both images.
	cmd = "curl -s -u api:#{apikey} --data-binary @#{png_file} 'https://api.tinypng.com/shrink'"
	puts cmd
	r = JSON.parse `#{cmd}`
	if r['error']
		puts "TinyPNG Error: #{r['message']} (#{r['error']})"
		exit(1)
	end
	url = r['output']['url']
	cmd = "curl -s '#{url}' -o #{dst}/#{png_file}"
	puts cmd
	`#{cmd}`
end
Dir.chdir("..")

puts 'Done'
