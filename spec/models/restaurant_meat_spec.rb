require "rails_helper"

describe RestaurantMeat do
  # Associations
  it { should belong_to(:restaurant) }
  it { should belong_to(:meat) }
end
