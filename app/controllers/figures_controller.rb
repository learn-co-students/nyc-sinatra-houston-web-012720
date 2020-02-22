class FiguresController < ApplicationController
  # add controller methods
  set :views, 'app/views/figures'
  
  get '/figures' do
    @figures = Figure.all 
    erb :index
  end
  
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :new
  end
  
  get '/figures/:id' do
      @figure = current_figure
      erb :show
  end

  get '/figures/:id/edit' do
    @figure = current_figure
    @titles = Title.all
    @landmarks = Landmark.all
    erb :edit
  end

  post "/figures" do
    new_figure =  Figure.create(params[:figure])
    # new_figure.titles << Title.create(params[:title])
    # params[:title][:name].delete("")
    # new_figure.landmarks << Landmark.create(params[:landmark])
    # params[:landmark][:name].delete("")
    # binding.pry

    if params[:title].count > 0
      new_figure.titles << Title.create(params[:title])
    end
    if params[:landmark].count > 0
      new_figure.landmarks << Landmark.create(params[:landmark])
    end
    params[:title][:name].delete("")
    params[:landmark][:name].delete("")

    new_figure.save
    redirect '/figures'
  end

  patch '/figures/:id' do
    figure = current_figure
    figure.update( params[:figure])
    redirect "/figures/#{figure.id}"
  end

    def current_figure
      Figure.find(params[:id])
    end

end
