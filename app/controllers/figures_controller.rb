class FiguresController < ApplicationController
  set :views, 'app/views/landmarks'
  register Sinatra::Twitter::Bootstrap::Assets
  set :methot_override, true

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :index
  end

  get '/landmarks/new' do
    @figures = Figure.all
    erb :new
  end

  post '/landmarks/new' do
    Landmark.create(year_completed: params[:landmark_year_completed], name: params[:landmark_name], figure_id: params[:figure_id])
    redirect '/landmarks'
  end

  get '/landmarks/:id' do
    @landmark = current_landmark

    erb :show
  end

  get '/landmarks/:id/edit' do
    @landmark = current_landmark
    @figures = Figure.all
    erb :edit
  end

  patch '/landmarks/:id/edit' do
    
    current_landmark.update(year_completed: params[:year_completed], name: params[:name], figure_id: params[:figure_id])
    redirect "/landmarks/#{params[:id]}"
  end

  delete '/landmarks/:id' do
    current_landmark.delete
    redirect '/landmarks'
  end

  def current_landmark
    Landmark.find(params[:id])
  end
end