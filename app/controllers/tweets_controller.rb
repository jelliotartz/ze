class TweetsController < ApplicationController

# include TwitterScraper

  def create

    tweeter = TwitterScraper.new
    @tweets = tweeter.user_timeline

    p "*" * 100
    @tweets.each do |tweet|
      p tweet.text
    end

    render 'show'
  end


  def show
    @tweet = client.user("gem")
    puts @tweet

  end

end
