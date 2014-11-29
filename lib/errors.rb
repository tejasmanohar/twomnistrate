require 'sinatra'

# 404 not found error
not_found do
  status 404
  erb :'404'
end

# twitter auth failure
get '/auth/failure' do
  # save full error message
  @message = params[:message]
  erb :'401'
end
