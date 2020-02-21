class LandmarksController < ApplicationController

  set :views, 'app/views/landmarks'

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :index
  end 

  get '/landmarks/new' do
    erb :new
  end  

  get '/landmarks/:id' do
    @landmark = current_landmark
    erb :show
  end 

  get '/landmarks/:id/edit' do
    @landmark = current_landmark
    erb :edit
  end

  post '/landmarks' do
    @landmark = Landmark.create(params)
    redirect "/landmarks/#{@landmark.id}" 
  end  

  patch '/landmarks/:id' do
    binding.pry
    @landmark = current_landmark
    @landmark.update(name: params[:name])
    redirect "/landmarks/#{@landmark.id}"
  end  

  def current_landmark
    Landmark.find(params[:id]) 
  end  

end
