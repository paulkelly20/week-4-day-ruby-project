require_relative( '../db/sqlrunner' )

class Artist

  attr_reader :id
  attr_accessor :name, :type, :about, :image

  def initialize(options)
    @id = options["id"].to_i
    @name = options["name"]
    @type = options["type"]
    @about = options["about"]
    @image = options["image"]
  end
  
  def save()
    sql = "INSERT INTO artists(name, type, about, image) VALUES ($1, $2, $3, $4) returning id"
    values = [@name, @type, @about, @image]
    result = SqlRunner.run(sql, values)
    @id = result.first()["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM artists"
    result = SqlRunner.run(sql)
    return Artist.map_artists(result)
  end

  def update()
    sql = "UPDATE artists SET (name, type, about, image) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @type, @about, @image, @id]
    SqlRunner.run(sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    artist = SqlRunner.run(sql,values)
    result = Artist.new(artist.first)
    return result
  end

  def delete_by_id()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end


  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def self.map_artists(artists)
    artists.map {|artist| Artist.new(artist)}
  end

end
