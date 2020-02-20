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

  get '/figures/:id/edit' do
    @figure = current_figure
    @landmarks = Landmark.all
    erb :edit
  end

  patch '/figures/:id/edit' do
    
    current_figure.update(name: params[:name])
    if params[:landmarks]
      params[:landmarks].each{ |landmark_id|
        Landmark.find(landmark_id).update(figure_id: params[:id])
      }
    end
    redirect "/figures/#{params[:id]}"
  end

  delete '/figures/:id' do
    current_figure.delete
    redirect '/figures'
  end

  def current_figure
    Figure.find(params[:id])
  end
end