class Organization
  include Mongoid::Document

  ## Fields
  field :name, :type => String
  field :picture_uid, :type => String

  ## Validators
  validates_uniqueness_of :name
  validates_presence_of :name

  ## Relationships
  has_and_belongs_to_many :customers
  has_and_belongs_to_many :users
  embeds_many :projects

end
