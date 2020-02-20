class LandmarksController < ApplicationController
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



# rspec ./spec/landmarks_controller_view_spec.rb:16 # LandmarksController allows you to view form to create a new landmark
# rspec ./spec/landmarks_controller_view_spec.rb:23 # LandmarksController allows you to create a new landmark
# rspec ./spec/landmarks_controller_view_spec.rb:31 # LandmarksController allows you to list all landmarks
# rspec ./spec/landmarks_controller_view_spec.rb:40 # LandmarksController allows you to see a single landmark
# rspec ./spec/landmarks_controller_view_spec.rb:48 # LandmarksController allows you to view the form to edit a single landmark
# rspec ./spec/landmarks_controller_view_spec.rb:62 # LandmarksController allows you to edit a single landmark