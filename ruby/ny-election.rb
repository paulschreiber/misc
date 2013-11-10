#!/usr/bin/ruby

## New York State polling place lookup
##
## Paul Schreiber <paulschreiber at gmail dot com>
## http://paulschreiber.com/
## release 10 November 2013
##
## Licensed under the MIT license
##
##

# assumes the presence of data.txt, a tsv file, with data like so:
# last, first, zip, county_name, dob (mm/dd/yy)


require 'rubygems'
require 'mechanize'

base_url = "https://voterlookup.elections.state.ny.us/"

agent = Mechanize.new

counties = {
  "01" => "Albany",
  "02" => "Allegany",
  "03" => "Bronx",
  "04" => "Broome",
  "05" => "Cattaraugus",
  "06" => "Cayuga",
  "07" => "Chautauqua",
  "08" => "Chemung",
  "09" => "Chenango",
  "10" => "Clinton",
  "11" => "Columbia",
  "12" => "Cortland",
  "13" => "Delaware",
  "14" => "Dutchess",
  "15" => "Erie",
  "16" => "Essex",
  "17" => "Franklin",
  "18" => "Fulton",
  "19" => "Genesee",
  "20" => "Greene",
  "21" => "Hamilton",
  "22" => "Herkimer",
  "23" => "Jefferson",
  "24" => "Kings",
  "25" => "Lewis",
  "26" => "Livingston",
  "27" => "Madison",
  "28" => "Monroe",
  "29" => "Montgomery",
  "30" => "Nassau",
  "31" => "New York",
  "32" => "Niagara",
  "33" => "Oneida",
  "34" => "Onondaga",
  "35" => "Ontario",
  "36" => "Orange",
  "37" => "Orleans",
  "38" => "Oswego",
  "39" => "Otsego",
  "40" => "Putnam",
  "41" => "Queens",
  "42" => "Rensselaer",
  "43" => "Richmond",
  "44" => "Rockland",
  "45" => "Saratoga",
  "46" => "Schenectady",
  "47" => "Schoharie",
  "48" => "Schuyler",
  "49" => "Seneca",
  "50" => "St.Lawrence",
  "51" => "Steuben",
  "52" => "Suffolk",
  "53" => "Sullivan",
  "54" => "Tioga",
  "55" => "Tompkins",
  "56" => "Ulster",
  "57" => "Warren",
  "58" => "Washington",
  "59" => "Wayne",
  "60" => "Westchester",
  "61" => "Wyoming",
  "62" => "Yates"
}

counties_by_name = counties.invert

lines = File.read("data.txt").split("\n")
lines.each_with_index do |line, index|
  last, first, zip, county, dob = line.split("\t")

  dob_parts = dob.split("/")
  dob = sprintf("%02d/%02d/19%02d", dob_parts[0], dob_parts[1], dob_parts[2])

  page = agent.get base_url
  search_form = page.forms[0]

  puts "[#{index}/#{lines.size}] Searching for #{first} #{last}..."

  search_form['ctl00$ContentPlaceHolder1$txtLastName'] = last
  search_form['ctl00$ContentPlaceHolder1$txtFirstName'] = first
  search_form['ctl00$ContentPlaceHolder1$txtZip'] = zip
  search_form['ctl00$ContentPlaceHolder1$txtDOB'] = dob
  search_form['ctl00$ContentPlaceHolder1$drpDownCounty'] = counties_by_name[county]

  button = search_form.button_with(:value => "Search")
  page = agent.submit(search_form, button)

  if page.search(".NoRecordsFound").empty?
    pp_name = page.search("#ctl00_ContentPlaceHolder1_lblPollingPlaceName").text
    pp_address = page.search("#ctl00_ContentPlaceHolder1_lblPollingPlaceAddress").text
    pp_csz = page.search("#ctl00_ContentPlaceHolder1_lblPollingPlaceCityStateZip").text

    puts line + "\t" + pp_name + "\t" + pp_address + "\t" + pp_csz
  else
    puts line + "\t--"
  end

end
