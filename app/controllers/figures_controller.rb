class FiguresController < ApplicationController

  set :views, 'app/views/figures'

  get '/figures' do
    @figures = Figure.all
    erb :index
  end  

  get '/figures/new' do
    @figures = Figure.all
    @titles = Title.all
    @landmarks = Landmark.all
    erb :new
  end  

  get '/figures/:id' do
    @figure = current_figure
    @landmarks = @figure.landmarks
    erb :show
  end 

  get '/figures/:id/edit' do
    @figure = current_figure
    erb :edit
  end

  post '/figures' do
    # binding.pry
    figure = Figure.create(params[:figure])
    
    # # Test for and create/associate titles with new figure
    # # Check if title text field is filled. Create new title and associate with figure if yes.
    # if params[:title][:name] != ""
    #   title = Title.create(name: params[:title][:name])
    #   FigureTitle.create(figure_id: figure.id, title_id: title.id)
    # end
    # # Check if any title checkboxes are checked. If yes, delete empty array elements and associate relevant ones to figure_title.
    # if params[:titles] && params[:titles].length > 0
    #   params[:titles].delete("")

    #   params[:titles].each do |id|
    #     FigureTitle.create(figure_id: figure.id, title_id: id)
    #   end
    # end
    
    # # Test for and create/associate landmarks with new figure
    # # Check if landmark text field is filled. Create new landmark (and year) and associate with figure if yes.
    # if params[:landmark][:name] != ""
    #   landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year])
    # end
    # # Check if any landmark checkbox is checked. If yes, delete empty array elements and associate relevant ones to figure.
    # if params[:landmarks] && params[:landmarks].length > 0
    #   params[:landmarks].delete("")

    #   params[:landmarks].each do |id|
    #     Landmark.find(id).update(figure_id: figure.id)
    #   end
    # end

    binding.pry
    redirect "/figures/#{figure.id}" 
  end  

  patch '/figures/:id' do
    binding.pry
    @figure = current_figure
    @figure.update(name: params[:name])
    redirect "/figures/#{@figure.id}"
  end  

  def current_figure
    Figure.find(params[:id]) 
  end  

end


