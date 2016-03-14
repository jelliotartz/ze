class SamplesController < ApplicationController
  require 'pry'

  def index
  end

  def input_text
  end

  def analyze

    if params[:tweet]
      tweeter = TwitterScraper.new
      tweet_objects = tweeter.user_timeline_20_recent(params[:tweet][:content])
      string_of_tweets = tweeter.concatenate_tweets(tweet_objects)
      @sample = Sample.new({content: string_of_tweets})
    elsif params[:file]
      binding.pry
        parsed_file = Yomu.new params[:file]
        @sample = Sample.new({content: parsed_file.text})
    else
      # just create sample
      @sample = Sample.new(sample_params)
    end

    caller = AlchemyCaller.new(@sample)
    caller.call_API
    caller.convert_to_keyword_objects

    @keywords = @sample.keywords
    calculator = MetricsCalculator.new(@sample.keywords)
    @averages = calculator.return_averages_by_gender

    @sample.user_id = session[:user_id]
    @sample.save

    render json: { sample: @sample, keywords: @keywords, averages: @averages }

  end

  def create
    puts @sample.text
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
