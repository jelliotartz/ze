class TweetsController < ApplicationController

# include TwitterScraper

  def get_username

    render 'show'
  end

  def show
    p params

    tweeter = TwitterScraper.new
    @tweet_objects = tweeter.user_whole_timeline(params[:username])
    # p "$" * 100
    # p @tweet_objects

    # @tweet_objects.each do |tweet|
    #   p tweet.text
    # end
    string_of_tweets = tweeter.concatenate_tweets(@tweet_objects)
    analyze_tweets(string_of_tweets)
  end

  def analyze_tweets(string_of_tweets)
    @sample = Sample.new({content: string_of_tweets})

    caller = AlchemyCaller.new(@sample)
    parsed_response = caller.call_API

    @gendered_keywords = GenderDetector.transform_all(parsed_response['keywords'])

    calculator = MetricsCalculator.new(@gendered_keywords)
    @averages = calculator.return_averages_by_gender

    render 'samples/new'
  end


  def new


  end



  def create

  end




  private
  def fetch_timeline_params
    params.require(:tweet).permit(:username)
  end

end
