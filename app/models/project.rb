class Project
  include Mongoid::Document

  ## Fields
  field :name, :type => String

  ## Validators
  validates_uniqueness_of :name

  ## Associations
  belongs_to :customer
  embeds_many :builds

end
