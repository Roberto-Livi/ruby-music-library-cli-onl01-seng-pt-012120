require 'pry'
class Song
  
  attr_accessor :name
  attr_reader :artist, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist unless artist == nil
    self.genre = genre unless genre == nil
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    @@all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(song)
    created_song = self.new(song)
    created_song.save
    created_song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end
  
  def self.find_by_name(name)
    @@all.find do |song|
      song.name == name
    end
  end
  
  def self.find_or_create_by_name(name)
    self.find_by_name(name) || self.create(name)
  end
  
  def self.new_from_filename(filename)
    artist, song, genre_name = filename.split(" - ")
    genre_fix = genre_name.gsub(".mp3", "")
    artist = Artist.find_or_create_by_name(artist)
    genre = Genre.find_or_create_by_name(genre_fix)
    new(song, artist, genre)
  end
  
  def self.create_from_filename(filename)
    new_from_filename(filename).save
  end
  
  
end

