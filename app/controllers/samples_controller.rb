class SamplesController < ApplicationController

  def new
  end

  def analyze
    caller = APICoordinator.new(params)
    caller.call_API
    sample = caller.create_sample
    if sample
      keywords = caller.create_keywords
      sample.user_id = session[:user_id]
      sample.save
      render json: { sample: sample, keywords: keywords },
      :status => 200
    else
      render json: "Our system did not find any text that it could analyze on that page.", :status => :bad_request
    end

  end

  def show
    sample = Sample.find_by(id: params[:id])
    render json: { sample: sample,
      keywords: sample.keywords }
  end

  def destroy
    @sample = Sample.find(params[:id])
    @sample.destroy
    @sample.keywords.destroy_all
    head :ok
    # if current_user
    #   redirect_to user_path(current_user.id)
    # else
    #   redirect_to root_path
    # end
  end

  def compare
    user = User.find_by(id: session[:user_id])
    respond_to do |format|
      format.html
      format.json { render json: { samples: user.samples, keywords: user.keywords }}
    end
  end

  private
  def sample_params
    params.require(:sample).permit(:content, :name)
  end
end
