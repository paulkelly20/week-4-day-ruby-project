require("sinatra")
require("sinatra/contrib/all")
require("pry-byebug")
require_relative("../models/album.rb")
require_relative("../models/artist.rb")
require_relative("../models/genre.rb")



get "/inventory" do
  @albums = Album.all()
  erb(:"inventory/index")
end
