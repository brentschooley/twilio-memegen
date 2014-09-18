require 'sinatra'
require 'twilio-ruby'
require 'unirest'

def match_memes(message)
  case message.downcase
  when /^(one does not simply)(.*)/
    return { id: 61579, top: $1, bottom: $2.strip! }
  when /^(what if i told you)(.*)/
    return { id: 100947, top: $1, bottom: $2.strip! }
  when /^(brace yourselves)(.*)/
    return { id: 61546, top: $1, bottom: $2.strip! }
  when /^(.*)(but that(?:')?s none of my business)/
    return { id: 16464531, top: $1.strip!, bottom: $2 }
  when /^(.*)((all the)(.*))/
    return { id: 61533, top: $1.strip!, bottom: $2 }
  when /^(.*)(ain(?:')?t nobody got time for that)/
    return { id: 442575, top: $1.strip!, bottom: $2 }
  when /^(.*)(we're dealing with a badass over here)/
    return { id: 11074754, top: $1.strip!, bottom: $2 }
  when /^(.*?)((a)+nd it(?:')?s gone)\z/
    return { id: 766986, top: $1.strip!, bottom: $2 }
  else
    return nil
  end
end

post '/phone/sms' do  
  content_type 'text/xml'

  message = params[:Body]

  # if message.casecmp "list"
  #   twiml = Twilio::TwiML::Response.new do |r|
  #     r.Message "Supported memes: ___ all the ___, what if i told you ___, brace yourselves ____, ___ but that's none of my business, ____ all the ____, ___ ain't nobody got time for that, ___ we're dealing with a badass over here, ___ aaaand it's gone"
  #   end
  #   return twiml.text
  # end

  meme_match = match_memes(message)

  if meme_match.nil?
    twiml = Twilio::TwiML::Response.new do |r|
      r.Message "Sorry, I don't know that meme! Send 'list' to see a list of supported memes."
    end
    return twiml.text
  else
    response = Unirest.post "https://api.imgflip.com/caption_image",
         parameters:
         {
            "username" => "brentschooley", 
            "password" => "k44a243i", 
            "template_id" => meme_match[:id], 
            "text0" => meme_match[:top], 
            "text1" => meme_match[:bottom]
        }

    image_url = response.body['data']['url']
  end

  twiml = Twilio::TwiML::Response.new do |r|
    r.Message do |m|
      m.Media "#{image_url}"
    end
  end

  twiml.text
end
