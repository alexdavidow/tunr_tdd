class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_and_belongs_to_many :albums

  def purchase(album)
    unless albums.include? album
      albums << album
    end 
  end

  def forget_albums
    self.albums = []
    self.save
  end
end
