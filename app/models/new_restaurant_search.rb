require "yelp"

class NewRestaurantSearch
  include ActiveModel::Model

  attr_accessor :query, :location

  def initialize(attributes = {})
    super
    @search_service = YelpService
  end

  def results
    if has_query?
      search.map do |result|
        OpenStruct.new(result)
      end
    end
  end

  private

  def has_query?
    query.present? && location.present?
  end

  def search_query
    { query: query, location: location }
  end

  def search
    @search_service.search(search_query)
  end
end
