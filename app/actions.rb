# Homepage (Root path)

helpers do
  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end
  def all_songs
    @songs = Song.all
  end
end

get '/', '/index' do
  erb :index
end

get '/song/add' do
  erb :add_song
end

post '/add_song' do
  @song = Song.new(
    title:  params[:title],
    author: params[:author],
    url:    params[:url],  
  )
  if current_user
    @song.user = current_user
  end
  if @song.save
    redirect '/index'
  else
    erb :new
  end
end

get '/signup' do
  erb :signup
end

post '/signup' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
  )
  if @user.save
    session[:user_id] = @user.id
    redirect '/index'
  else
    erb :signup
  end
end

get '/signin' do
  erb :signin
end

post '/signin' do
  # session[:user_id] = nil
  # binding.pry
  @user = User.find_by(username: params[:username])
  if @user.password == params[:password]
    session[:user_id] = @user.id
    redirect '/'
  else
    redirect '/signin'
  end
end

post '/signout' do
  session.clear
  redirect '/'
end

post '/review' do
  @review = Review.new(
    user: current_user,
    song: Song.find(params[:song_id]),
    content: params[:review]
  )
  @review.save
  redirect '/'
end

post '/delete_post' do
  
  Review.find(params[:review_id]).destroy
  redirect '/'
end
