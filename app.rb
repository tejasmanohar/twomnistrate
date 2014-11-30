# require gems
require 'bundler/setup'
require 'orchestrate'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
Bundler.require

# set 'sessions' setting true
enable :sessions

# setup orchestrate client
app = Orchestrate::Application.new(ENV['API_KEY'])

# object within client for phrases collection
phrases = app[:phrases]

# setup omniauth with twitter oauth2 provider
use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end

# helper methods
helpers do
  # check if user is logged_in via session var
  def logged_in?
    session[:authed]
  end
end

# homepage
get '/' do
  # redirect to list if logged_in
  if logged_in?
    redirect '/all'
  else
    erb :home
  end
end

# list all phrases
get '/all' do
  erb :all
end

# submit new phrase
get '/new' do
  # stop user if they're not logged in
  halt(401,'Not Authorized') unless logged_in?
  erb :new
end

# capture user input
post '/new' do
  # push user data to orchestrate here
  redirect '/all'
end

# logout
get '/logout' do
  # change session var to reflect logout
  session[:authed] = nil
  erb :out
end

# login
get '/auth/twitter/callback' do
  # change session var to reflect login
  session[:authed] = true
  erb :in
end

# login failure
get '/auth/failure' do
  # display full error message
  params[:message]
end