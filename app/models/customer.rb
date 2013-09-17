class Customer
  include Mongoid::Document
  validates_uniqueness_of :name
  field :name, :type => String
  field :image_uid, :type => String
  image_accessor :image
  has_and_belongs_to_many :users
end