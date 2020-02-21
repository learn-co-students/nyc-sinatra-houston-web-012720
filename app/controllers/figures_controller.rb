class FiguresController < ApplicationController
  set :views, "app/views/figures"
  set :erb, layout: :"/../layout"
  register Sinatra::Twitter::Bootstrap::Assets
  set :method_override, true

  get '/figures' do
    @figures = Figure.all

    erb :index
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :new
  end

  post '/figures/new' do
    figure = Figure.create(name: params[:figure_name])
    
    
      Landmark.all.each { |landmark|
        if params.has_key?("landmark_#{landmark.id}")
          landmark.update(figure_id: figure.id)
        end
      }
    
    
      Title.all.each { |title|
        if params.has_key?("title_#{title.id}")
          FigureTitle.create(title_id: title.id ,figure_id: figure.id)
        end
      }
    
    if params[:new_landmark]

      landmark = Landmark.create(name: params[:new_landmark], figure_id: figure.id)

    end

    if params[:new_title]

      title = Title.create(name: params[:new_title])
      FigureTitle.create(title_id: title.id ,figure_id: figure.id)

    end

    redirect '/figures'
  end

  get '/figures/:id' do
    @figure = current_figure


    erb :show
  end

  get '/figures/:id/edit' do
    @figure = current_figure
    @landmarks = Landmark.all
    erb :edit
  end

  patch '/figures/:id/edit' do
    
    current_figure.update(name: params[:figure_name])
    if params[:new_landmark]

      landmark = Landmark.find_or_create_by(name: params[:new_landmark])
      landmark.update(figure_id: params[:id])
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