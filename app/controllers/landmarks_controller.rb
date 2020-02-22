class LandmarksController < ApplicationController
  # add controller methods
  set :views, "app/views/landmarks"

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :index
  end

  get "/landmarks/:id" do
    @landmark = Landmark.find(params[:id])
    erb :show
  end

  
end
