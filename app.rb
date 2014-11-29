require 'sinatra'
require 'sinatra/flash'
require 'sinatra/reloader' if development?

require 'orchestrate'

require 'pry' if development?

require 'bundler'
Bundler.require
 
helpers do
  def admin?
    true
  end
end
 
get '/public' do
  "This is the public page - everybody is welcome!"
end
 
get '/private' do
  halt(401,'Not Authorized') unless admin?
  "This is the private page - members only"
end

