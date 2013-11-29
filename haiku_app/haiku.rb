require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'
require 'pry'

@@db ||= SQLite3::Database.new( "data.db" )
@@db.execute("CREATE TABLE if not exists haiku (
    book string,
    author string,
    poem text)"
   )

get '/' do
  @haikus = @@db.execute('select * from haiku')

  if @haikus.empty?
    @nothing = "There aren't any haikus yet. :("
    erb :empty
  else
    erb :homepage
  end
end

get '/enter' do
  erb :enter
end

post '/post' do
    @book = params[:book]
    @author = params[:author]
    @poem = params[:poem]
  @@db.execute("INSERT INTO haiku VALUES ('#{@book}', '#{@author}', '#{@poem}')")

  redirect '/'
end

