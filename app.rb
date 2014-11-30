# require gems
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'orchestrate'
require 'pry' if development?
Bundler.require

enable :sessions

use OmniAuth::Builder do
  provider :twitter, ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']
end

# helper methods
helpers do
  # is the user logged_in?
  def logged_in?
    session[:authed]
  end
end

# homepage
get '/' do
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
  halt(401,'Not Authorized') unless logged_in?
  erb :new
end

post '/new' do
  # push user data to orchestrate
  redirect '/all'
end

get '/login' do
  redirect to('/auth/twitter')
end

get '/logout' do
  session[:authed] = nil
  erb :out
end

get '/auth/twitter/callback' do
  session[:authed] = true
  session[:username] = env['omniauth.auth']['info']['name']
  erb :in
end

get '/auth/failure' do
  params[:message]
end
