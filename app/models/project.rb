class Project
  include Mongoid::Document

  ## Fields
  field :name, :type => String

  ## Validators
  validates_uniqueness_of :name
  validates_presence_of :name

  ## Associations
  embedded_in :organization
  has_and_belongs_to_many :customers
  embeds_many :ipaapps
  embeds_many :apkapps

end
