require "rails_helper"

describe Restaurant do
  # Associations
  it { should have_many(:sources).through(:restaurant_sources) }
  it { should have_many(:meats).through(:restaurant_meats) }

  # Validations
  it { should validate_presence_of(:api_id) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:display_address) }
  it { should validate_presence_of(:phone) }
  it { should validate_presence_of(:coordinate) }
end
