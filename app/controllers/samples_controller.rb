class SamplesController < ApplicationController
  require 'pry'

  def index
  end

  def input_text
  end

  def show
    tweeter = TwitterScraper.new
    @tweet_objects = tweeter.user_timeline_20_recent(params[:username])

    @string_of_tweets = tweeter.concatenate_tweets(@tweet_objects)
    # params[:sample][:content] = @string_of_tweets
    # redirect_to analyze_path
    @sample = Sample.new({content: @string_of_tweets})

    analyze(@sample)
  end

  def analyze(sample)
    @sample = sample
    caller = AlchemyCaller.new(@sample)
    caller.call_API
    caller.convert_to_keyword_objects

    @keywords = @sample.keywords
    calculator = MetricsCalculator.new(@sample.keywords)
    @averages = calculator.return_averages_by_gender

    @sample.user_id = session[:user_id]
    @sample.save

    render json: { sample: @sample, keywords: @keywords }

  end

  def create
    puts @sample.text
  end

  def get_username
    p "*" * 100
    p "*" * 100
    p params
    tweeter = TwitterScraper.new
    @tweet_objects = tweeter.user_timeline_20_recent(params[:username])

    @string_of_tweets = tweeter.concatenate_tweets(@tweet_objects)
  end

  def new
  end

  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy
    @sample.keywords.destroy_all
    if current_user
      redirect_to user_path(current_user.id)
    else
      redirect_to root_path
    end
  end

  private
  def sample_params
    params.require(:sample).permit(:content)
  end
end
