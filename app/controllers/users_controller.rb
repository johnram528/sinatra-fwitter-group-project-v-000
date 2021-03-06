class UsersController < ApplicationController
  get '/signup' do
    if logged_in? 
      redirect '/tweets'
      status 200
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if !logged_in?
      user = User.new(params) 
      if user.save
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/signup'
      end
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in? 
      redirect '/tweets'
    else
      erb :'/users/login'
    end  
  end

  post '/login' do
    if !logged_in?
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tweets'
      else
        redirect '/login'
      end
    else
      redirect '/tweets'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/user_show'
  end

end