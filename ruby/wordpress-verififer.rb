#!/usr/bin/ruby

require 'mail'

SENDER = 'sender@example.com'.freeze
RECIPIENT = 'me@example.com'.freeze

domains = [
  'example.com',
  'mysite.site'
]

failures = []
domains.each do |d|
  Dir.chdir("/var/www/#{d}")
  failures << d unless system('/usr/local/bin/wp core verify-checksums')
end

unless failures.empty?
  mail = Mail.new do
    from    SENDER
    to      RECIPIENT
    subject 'WordPress checksum verification failed'
    body    failures.join("\n")
  end

  mail.delivery_method :sendmail
  mail.deliver
end
