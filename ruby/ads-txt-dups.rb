#!/usr/bin/ruby

data = File.read('/tmp/foo.txt').split("\n")
already_seen = {}

data.each_with_index do |line, index|
	# puts line
	if already_seen.has_key?(line)
		already_seen[line] = already_seen[line] + 1
		# puts "#{index+1} #{line}"
	else
		already_seen[line] = 1
		puts line
	end
end

