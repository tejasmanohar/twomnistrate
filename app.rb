# require gems
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'orchestrate'
require 'pry' if development?
Bundler.require

# require code
require_relative 'lib/auth'
require_relative 'lib/errors'
# require_relative 'lib/helpers'

# homepage
get '/' do
  erb :home
end

# submit your favorite phrase
get '/input' do
  erb :'401' unless admin?
  erb :input
end

# capture user input
post '/input' do
  # omnistrate code
end

# view favorite phrase of others
get '/input/:username' do
  erb :'401' unless logged_in?
  erb :input
end

__END__
@@layout
<% title="Songs By Sinatra" %>
<!doctype html>
<html>
  <head>
    <title><%= title %></title>
    <meta charset="utf-8">
  </head>
  <body>
    <header>
      <h1><%= title %></h1>
    </header>
    <section>
      <%= yield %>
    </section>
  </body>
</html>