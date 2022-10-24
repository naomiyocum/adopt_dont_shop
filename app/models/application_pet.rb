class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def pet_approved
    update_attribute(:status, "Approved")
  end

  def pet_rejected
    update_attribute(:status, "Rejected")
  end

  def self.find_me(app_id, p_id)
    find_by(application_id: app_id, pet_id: p_id)
  end
end