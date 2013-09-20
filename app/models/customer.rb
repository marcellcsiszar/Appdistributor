class Customer
  include Mongoid::Document

  ## Fields
  field :name, :type => String
  field :image_uid, :type => String

  ## Accessors
  image_accessor :image

  ## Validators
  validates_uniqueness_of :name

  ## Associations
  has_and_belongs_to_many :users
  has_many :projects

end
