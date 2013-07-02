class Album < ActiveRecord::Base
  attr_accessible :image_url, :name

  validates_presence_of :name, :image_url

  has_and_belongs_to_many :users
  has_many :songs
end
