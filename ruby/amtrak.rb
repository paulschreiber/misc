#!/usr/bin/ruby

## Amtrak station checked-baggage status
##
## Paul Schreiber <paulschreiber at gmail dot com>
## http://paulschreiber.com/
## 1.0  -- 13 October 2013
##
## Licensed under the MIT license
##
##

require 'open-uri'
require 'nokogiri'

station_list_base_url = "http://www.amtrak.com/html/stations_%s.html"
station_info_base_url = "http://www.amtrak.com/servlet/ContentServer?pagename=am/am2Station/Station_Page&code=%s"

def station_index_pages
  doc = Nokogiri::HTML.parse(open(station_list_base_url % "A"))

  doc.css(".orangeletter,.whiteletter").collect(&:content)
end

def station_names(index_pages)
  station_names = {}

  index_pages.each do |ip|
    doc = Nokogiri::HTML.parse(open(base_station_list_url % ip))
    doc.css("span").collect(&:content).select{|x| x.length == 3}.each{|station| station_names[station] = false}
  end

  station_names
end

def update_station_baggage_status(station_status_hash)
  station_status_hash.each_key do |code|
    puts "Checking %s" % code
    doc = Nokogiri::HTML.parse(open(station_info_base_url % code))
    if doc.search("[text()*='No Checked Baggage Service']").empty?
      station_status_hash[code] = true
    end
  end
end

station_status_hash = station_names(station_index_pages)
update_station_baggage_status(station_status_hash)

stations_with_baggage = station_status_hash.select{|k,v| v == true}.collect{|x| x.first}.sort
puts stations_with_baggage
