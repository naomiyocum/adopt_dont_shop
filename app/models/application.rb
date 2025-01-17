class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets

  validates :name, :street_address, :city, :state, :description, :status, :presence => true
  validates :zipcode, presence: :true, numericality: :true

  def add_pet(pet_id)
    self.pets << Pet.find(pet_id)
  end

  def to_pending
    update_attribute(:status, "Pending")
  end

  def to_approved
    update_attribute(:status, "Approved")
  end

  def to_rejected
    update_attribute(:status, "Rejected")
  end
end
