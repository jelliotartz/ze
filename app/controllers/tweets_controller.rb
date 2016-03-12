class TweetsController < ApplicationController

# include TwitterScraper

  def get_username

    render 'show'
  end

  def show
    p params

    tweeter = TwitterScraper.new
    @tweet_objects = tweeter.user_whole_timeline(params[:username])
    p "$" * 100
    p @tweet_objects

    @tweet_objects.each do |tweet|
      p tweet.text
    end
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
