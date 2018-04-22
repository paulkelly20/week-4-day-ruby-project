require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/album.rb")
require_relative("../models/artist.rb")
require_relative("../models/genre.rb")


get "/albums" do
  @albums = Album.all()
  erb(:"albums/index")
end

get "/albums/new" do
  @artists = Artist.all()
  @genres = Genre.all()
  erb(:"albums/new")
end

get "/albums/:id" do
  @album = Album.find(params['id'].to_i)
  erb(:"albums/album")
end

post "/albums" do
  new_album = Album.new(params)
  new_album.save()
  redirect to "/albums"
end

get "/albums/:id/update" do
  @artists = Artist.all()
  @genres = Genre.all()
  @album = Album.find(params[:id])
  erb(:"albums/edit")
end

post "/albums/:id" do
  new_album = Album.new(params)
  new_album.update()
  redirect to "/albums"
end

post "/albums/:id/delete" do
 @album = Album.find(params[:id])
 @album.delete_by_id()
 redirect to "/albums"
end