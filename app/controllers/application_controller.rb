class ApplicationController < Sinatra::Base
  set :views, proc { File.join(root, '../views/') }
  set :method_overide, true

  register Sinatra::Twitter::Bootstrap::Assets

  get '/' do
    erb :"application/index"
  end
end
