# require gems
require 'bundler/setup'
require 'orchestrate'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry' if development?
Bundler.require

enable :sessions

app = Orchestrate::Application.new(ENV['API_KEY'])
phrases = app[:phrases]

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

post '/new' do
  # push user data to orchestrate here
  redirect '/all', notice: 'The phrase was successfully submitted!'
end

get '/logout' do
  # change session var to reflect logout
  session[:authed] = nil
  erb :out
end

get '/auth/twitter/callback' do
  # change session var to reflect login
  session[:authed] = true
  erb :in
end

get '/auth/failure' do
  # display full error message
  params[:message]
end