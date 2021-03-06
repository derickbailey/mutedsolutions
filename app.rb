require 'compass' #must be loaded before sinatra
require 'sinatra'
require 'haml' #must be loaded after sinatra

# set sinatra's variables
set :app_file, __FILE__
set :root, File.dirname(__FILE__)
set :views, 'views'
set :public, 'public'

configure do
  Compass.add_project_configuration(File.join(Sinatra::Application.root, 'config', 'compass.config'))
end

# at a minimum, the main sass file must reside within the ./views directory. here, we create a ./views/stylesheets directory where all of the sass files can safely reside.
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass(:"stylesheets/#{params[:name]}", Compass.sass_engine_options )
end

get '/' do
  haml :index
end

get '/:view' do
  view = params[:view].to_sym

  haml_file = File.expand_path(File.join(File.dirname(__FILE__), "views", "#{view}.haml"))

  if File.exist? haml_file
    haml view
  else
    not_found
  end
end

