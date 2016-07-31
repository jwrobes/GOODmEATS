require "rails_helper"

describe RestaurantSource do
  # Associations
  it { should belong_to(:restaurant) }
  it { should belong_to(:source) }
end
