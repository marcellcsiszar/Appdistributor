class Project
  include Mongoid::Document
  validates_uniqueness_of :name
  field :name, :type => String
  belongs_to :customer
  embeds_many :builds
end
