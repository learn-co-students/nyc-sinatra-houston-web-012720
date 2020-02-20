class FiguresController < ApplicationController
  set :views, 'app/views/landmarks'
  register Sinatra::Twitter::Bootstrap::Assets
  set :method_override, true

  get '/figures' do
    @figures = Figure.all
    erb :index
  end

  get '/figures/new' do
    @figures = Figure.all
    erb :new
  end

  post '/figures/new' do
    Figure.create(name: params[:figure_name])
    redirect '/figure'
  end

  get '/figures/:id' do
    @figures = current_figure

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