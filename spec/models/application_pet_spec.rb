require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  let!(:garden) {Shelter.create!(name: 'Animal Garden', city: 'Okinawa City', foster_program: false, rank: 7)}
  let!(:mystery) {Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:friends) {Shelter.create!(name: 'Dumb Friends League', city: 'Denver', foster_program: true, rank: 1)}
  let!(:bounce) {Shelter.create!(name: 'Bounce Rescue', city: 'Aurora', foster_program: false, rank: 15)}
  let!(:app) {Application.create!(name: "Miley Cyrus", street_address: "123 Hollywood Blvd", city: "Los Angeles", state: "California", zipcode: 12345, description: "I am rich and hot", status: "In Progress")}
  let!(:kenz) {Application.create!(name: "Kenz L", street_address: "318 E 3rd Ave", city: "Durango", state: "Colorado", zipcode: 81301, description: "Please let me adopt a pet!", status: "Pending")}
  let!(:lauren) {Application.create!(name: "Lauren D", street_address: "55 Mauldeth Drive", city: "Chattanooga", state: "Tennessee", zipcode: 37405, description: "I really need a pet or I will continue to be sad.", status: "Pending")}
  let!(:reba) {friends.pets.create(name: 'Reba', age: 6, breed: 'Jack Russel Terrier mix', adoptable: true)}
  let!(:pimento) {bounce.pets.create(name: 'Pimento', age: 1, breed: 'Corgi', adoptable: true)}
  
  describe "relationships" do
    it {should belong_to :application}
    it {should belong_to :pet}
  end

  describe 'instance methods' do
    describe '#pet_approved' do
      it 'approves the pet application' do
        ap_1 = ApplicationPet.create!(application: app, pet: reba)

        expect(ap_1.status).to eq(nil)

        ap_1.pet_approved

        expect(ap_1.status).to eq('Approved')
      end
    end

    describe '#pet_rejected' do
      it 'rejects the pet application' do
        ap_1 = ApplicationPet.create!(application: app, pet: reba)

        expect(ap_1.status).to eq(nil)

        ap_1.pet_rejected

        expect(ap_1.status).to eq('Rejected')
      end
    end
  end

  describe 'class methods' do
    describe '#find_me' do
      it 'returns this specific ApplicationPet' do
        ap_1 = ApplicationPet.create!(application: app, pet: reba)
        ap_2 = ApplicationPet.create!(application: kenz, pet: pimento)

        expect(ApplicationPet.find_me(app.id, reba.id)).to eq(ap_1)
      end
    end
  end
end