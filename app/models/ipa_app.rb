class IpaApp
  include Mongoid::Document

  ## Fields
  field :name, :type => String

  ## Validators
  validates_uniqueness_of :name

  ## Associations
  embedded_in :project
  embeds_many :ipabuilds

end
