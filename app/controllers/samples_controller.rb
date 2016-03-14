class SamplesController < ApplicationController
  require 'pry'

  def index
  end

  def input_text
  end

  def analyze
    puts params
    puts "*" * 100
    puts "*" * 100
    puts "*" * 100
    puts "*" * 100
    if params[:image]
      engine = Tesseract::Engine.new do |config|
        config.language  = :eng
        config.blacklist = '|'
      end
      def clean(text)
        text.split(/\n/).compact.select { |v| v.size > 0 }
      end
      if remotipart_submitted?
        new_image = params[:image][:filename].path
        p new_image
      else
        p "NOT XHR!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        new_image =  params[:image][:filename].path
        p new_image
      end
      p "AT THE END OF IMAGE SECTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      text_from_image = clean(engine.text_for(new_image))
      @sample = Sample.new({content: text_from_image})
    elsif params[:tweet]
      tweeter = TwitterScraper.new
      tweet_objects = tweeter.user_timeline_20_recent(params[:tweet][:content])
      string_of_tweets = tweeter.concatenate_tweets(tweet_objects)
      @sample = Sample.new({content: string_of_tweets})
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

    render json: { sample: @sample, keywords: @keywords }

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
