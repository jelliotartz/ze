class TweetsController < ApplicationController

  def get_username
    render 'show'
  end

  def show
    tweeter = TwitterScraper.new
    @tweet_objects = tweeter.user_timeline_20_recent(params[:username])

    string_of_tweets = tweeter.concatenate_tweets(@tweet_objects)
    analyze_tweets(string_of_tweets)
  end

  def analyze_tweets(string_of_tweets)
    @sample = Sample.new({content: string_of_tweets})

    caller = AlchemyCaller.new(@sample)

    caller.call_API
    caller.convert_to_keyword_objects

    @keywords = @sample.keywords
    calculator = MetricsCalculator.new(@sample.keywords)
    @averages = calculator.return_averages_by_gender

    @sample.user_id = session[:user_id]
    @sample.save

    render 'samples/new'
  end

end
