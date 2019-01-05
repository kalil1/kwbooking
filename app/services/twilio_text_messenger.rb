class TwilioTextMessenger
  attr_reader :message
  attr_reader :phone

  def initialize(message, phone)
    @phone = phone
    @message = message
  end
  def call
    client = Twilio::REST::Client.new("ACd5f3a912cb99da50253d0f655ffe27c1", "0f41daf9fb42b2b79986613348774eaf")
    client.messages.create({
      from: "+17864085118",
      to: "+1#{phone}",
      body: message
    })
  end
end
