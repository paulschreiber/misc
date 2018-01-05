#!/usr/bin/ruby

## Batch convert .webarchive to .mailsignature
##
## Paul Schreiber <paulschreiber at gmail dot com>
## http://paulschreiber.com/
## 1.0 / 4 January 2018
##
## Licensed under the MIT license
##
##

require 'cfpropertylist'
require 'securerandom'

base_path = '~/Library/Mail/V5/MailData/Signatures/'
hostname = 'apple.com'

Dir.chdir(File.expand_path(base_path))
web_archives = Dir.glob('*.webarchive')

web_archives.each do |current_archive|
  puts "Converting #{current_archive}..."

  plist = CFPropertyList::List.new(file: current_archive)
  data = CFPropertyList.native_types(plist.value)
  html = data['WebMainResource']['WebResourceData'].gsub(%r{</?HTML>}i, '')
  content = [html].pack('M')
  uuid = SecureRandom.uuid.upcase

  message = <<SIGNATURE
  Content-Transfer-Encoding: quoted-printable
  Content-Type: text/html;
  	charset=utf-8
  Message-Id: <#{uuid}@#{hostname}>
  Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))

  #{content}
SIGNATURE

  output_file = wa.gsub('webarchive', 'mailsignature')
  File.open(output_file, 'w') do |file|
    file.write(message)
  end
end
