class TwilioTextMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    client = Twilio::REST::Client.new("AC5658f5b3db1822c4316e867581b01604", "0b650725d214c83b69d1fd7750e9cd88")
    client.messages.create({
      from: "+17864085118",
      to: '+17866619324',
      body: message
    })
  end
end
