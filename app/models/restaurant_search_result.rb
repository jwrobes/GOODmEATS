class RestaurantSearchResult
  include ActiveModel::Model

  attr_accessor :name, :api_id, :display_address,
                :coordinate, :phone, :goodmeat_matcher

  validates :name, :api_id, :display_address,
            :coordinate, :phone, :goodmeat_matcher, presence: true

  def initialize(attributes = {})
    super
  end

  def has_goodmeat?
    goodmeat_matcher.has_matching_api_id?(api_id)
  end
end
