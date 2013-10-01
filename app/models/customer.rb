class Customer
  include Mongoid::Document

  ## Fields
  field :name, :type => String
  field :image_uid, :type => String

  ## Accessors
  image_accessor :image

  ## Validators
  validates_uniqueness_of :name
  validates_presence_of :name
  validates_presence_of :organization

  ## Associations
  belongs_to :organization
  has_many :users
  belongs_to :project
end
