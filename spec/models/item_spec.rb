require 'rails_helper'

RSpec.describe Item do
  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :description}
  end

  describe 'Relationships' do
    it {should belong_to :merchant}
  end
end
