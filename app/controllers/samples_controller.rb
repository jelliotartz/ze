class SamplesController < ApplicationController

  def index
  end

  def input_text
  end

  def analyze
<<<<<<< HEAD
    if params[:image]
      # Pull sample from image through Tesseract
      engine = Tesseract::Engine.new do |config|
        config.language  = :eng
        config.blacklist = '|'
      end
      def clean(text)
        text.split(/\n/).compact.select { |v| v.size > 0 }
      end
      if remotipart_submitted?
        new_image = params[:image][:filename].path
      else
        new_image =  params[:image][:filename].path
      end
      text_from_image = clean(engine.text_for(new_image))
      @sample = Sample.new({content: text_from_image})
    elsif params[:tweet]
      # Pull sample from twitter through scraper
      tweeter = TwitterScraper.new
      tweet_objects = tweeter.user_timeline_20_recent(params[:tweet][:content])
      string_of_tweets = tweeter.concatenate_tweets(tweet_objects)
      @sample = Sample.new({content: string_of_tweets})
    elsif params[:file]
      # pull sample from dropped file through Yomu
      parsed_file = Yomu.new params[:file].tempfile
      @sample = Sample.new({content: parsed_file.text})
    else
      # just create sample
      @sample = Sample.new(sample_params)
    end
=======

    if params[:url]

      res = HTTParty.post("http://gateway-a.watsonplatform.net/calls/url/URLGetRankedNamedEntities",
      :query => { :apikey => ENV["URL_SECRET_ALCHEMY"],
                 :url => params[:url][:url],
                 :sourceText => "cleaned",
                 :showSourceText => 1,
                 :outputMode => 'json',
                 :sentiment => 1
               },
      :headers => { 'Content-Type' => 'application/x-www-form-urlencoded' } )
      @sample = Sample.new({content: res["text"]})

      caller = AlchemyCaller.new(@sample)
      caller.response = res
      caller.convert_to_keyword_objects_url

      @keywords = @sample.keywords
      calculator = MetricsCalculator.new(@sample.keywords)
      @averages = calculator.return_averages_by_gender

      @sample.user_id = session[:user_id]
      @sample.save

      render json: { sample: @sample, keywords: @keywords, averages: @averages }
    else
      if params[:tweet]
        tweeter = TwitterScraper.new
        tweet_objects = tweeter.user_timeline_20_recent(params[:tweet][:content])
        string_of_tweets = tweeter.concatenate_tweets(tweet_objects)
        @sample = Sample.new({content: string_of_tweets})
      elsif params[:file]
        parsed_file = Yomu.new params[:file].tempfile
        @sample = Sample.new({content: parsed_file.text})
      else
        # just create sample
        @sample = Sample.new(sample_params)
      end
>>>>>>> master

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
