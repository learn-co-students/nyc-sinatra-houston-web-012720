class ApplicationController < Sinatra::Base
  set :views, "app/views/application"
  set :erb, layout: :"/../layout"
  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :index
  end



end
