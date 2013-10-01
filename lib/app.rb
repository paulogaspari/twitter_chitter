
#   Document setup
#######################################################################################
require 'sinatra/base'
require 'sinatra/partial'
require 'rack-flash'
require 'data_mapper'
require_relative 'helpers'
require_relative 'data_mapper_setup'




#   Bookmark Manager App
#######################################################################################

class TwitterChitter < Sinatra::Base
  register Sinatra::Partial
  set :partial_template_engine, :erb
  set :views, File.join(File.dirname(__FILE__), '..', 'views')
  set :public_folder, File.join(File.dirname(__FILE__), '..', 'public')

  enable :sessions
  set :session_secret, "I'm the secret key to sign the cookie"

  use Rack::Flash, :sweep => true
  use Rack::MethodOverride
  helpers UsersHelper


  get '/' do
  	@posts = Post.all
  	erb :index
  end

  get '/about' do
    erb :about
  end

  get '/userprofile' do
    erb :userprofile
  end


#   ADDING POSTS
###################################################################

  post '/posts' do
  	content = params['body']
  	title = params['title']
  	tags = params["tags"].split(" ").map{|tag| Tag.first_or_create(:text => tag)}
    user = User.first_or_create(:username => params['username'])
    time = Time.now
  	Post.create(:body => content, :title => title, :tags => tags, :user => user, :created_at => time)
  	redirect to('/')
  end



#   SORTING BY TAGS
###################################################### => #############
 
  get '/tags/:text' do
  	tag = Tag.first(:text => params[:text])
  	@posts = tag ? tag.posts : []
  	erb :index
  end



#   USERS
###################################################################

  get '/users/new' do
    @user = User.new
    erb :new_user
  end


  post '/users' do
    @user = User.create(:email => params[:email],
                :password => params[:password],
                :password_confirmation => params[:password_confirmation],
                :firstname => params[:firstname],
                :lastname => params[:lastname],
                :username => params[:username])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :new_user
    end
  end



#   SESSION
###################################################################



  post '/session' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password are incorrect"]
      redirect to('/')
    end
  end


  delete '/session' do
    flash[:notice] = "Good bye!"
    session[:user_id] = nil
    redirect to('/')
  end


end




