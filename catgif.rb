require 'sinatra'
require 'twilio-ruby'
require 'unirest'

post '/phone/sms' do  
  content_type 'text/xml'

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message do |m|
      m.Media "http://thecatapi.com/api/images/get?format=src&type=gif"
    end
  end

  twiml.text
end
