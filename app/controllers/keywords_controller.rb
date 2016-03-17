class KeywordsController < ApplicationController
  def update
    keyword = Keyword.find_by(id: params[:id])
    keyword.gender = params[:gender]
    keyword.save
    head :ok
  end

  def compare
  end
end