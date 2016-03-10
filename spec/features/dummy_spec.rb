require 'rails_helper'

describe "dummy" do
  it "visits a website successfully" do
    visit "/"
    expect(page).to have_current_path("http://devbootcamp.com/")
  end
end