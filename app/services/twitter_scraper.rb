require 'twitter'

class TwitterScraper

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
    end
  end

  def user_timeline_20_recent(handle)
    twitter_output = @client.user_timeline(handle)
  end



  def self.search
    client.search("to:justinbieber marry me", result_type: "recent").take(3).each do |tweet|
      puts tweet.text
    end
  end


end


