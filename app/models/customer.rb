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

  ## Associations
  has_and_belongs_to_many :organizations
  has_and_belongs_to_many :users
  belongs_to :project

end
