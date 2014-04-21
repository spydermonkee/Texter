class Text < ActiveRecord::Base
  before_create :send_text

private

  def send_text
    begin
      response = RestClient::Request.new(
        :method => :post,
        :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Texts.json",
        :user => ENV['TWILIO_ACCOUNT_SID'],
        :password => ENV['TWILIO_AUTH_TOKEN'],
        :payload => { :Body => body,
                      :To => to,
                      :From => from }
      ).execute
    rescue
      false
    end
  end
end
