require 'rails_helper'

RSpec.describe 'admin application show page', type: :feature do
  let!(:app) {Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "Pending")}
  let!(:shelter) {Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:scooby) {shelter.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)}
  let!(:scrappy) {shelter.pets.create!(name: 'Scrappy', age: 6, breed: 'Great Dane', adoptable: true)}


  describe 'the application show page if an admin is viewing' do
    it 'has a button to approve for each pet' do
      ApplicationPet.create!(application: app, pet: scooby)
      ApplicationPet.create!(application: app, pet: scrappy)

      visit "/admin/applications/#{app.id}"

      within("#petbox-#{scooby.id}") do
        click_button('Approve')
      end

      expect(page).to have_content('Scooby has been approved!')
      expect(page).to have_selector(:link_or_button, "Approve")
      expect(page).to have_selector(:link_or_button, "Reject")

      within("#petbox-#{scrappy.id}") do
        click_button('Approve')
      end

      expect(page).to have_content('Scrappy has been approved!')
    end

    it 'has a button to reject for each pet' do
      ApplicationPet.create!(application: app, pet: scooby)
      ApplicationPet.create!(application: app, pet: scrappy)

      visit "/admin/applications/#{app.id}"

      within("#petbox-#{scrappy.id}") do
        click_button "Reject"
      end

      within("#petbox-#{scooby.id}") do
        click_button('Reject')
      end

      expect(page).to have_content('Scrappy has been rejected.')
      expect(page).to have_content('Scooby has been rejected.')
    end

    it 'can reject and approve at the same time' do
      ApplicationPet.create!(application: app, pet: scooby)
      ApplicationPet.create!(application: app, pet: scrappy)

      visit "/admin/applications/#{app.id}"

      within("#petbox-#{scrappy.id}") do
        click_button "Reject"
      end

      within("#petbox-#{scooby.id}") do
        click_button('Approve')
      end

      expect(page).to have_content('Scrappy has been rejected.')
      expect(page).to have_content('Scooby has been approved!')
    end
  end
end