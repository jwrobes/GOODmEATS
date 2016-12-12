class RestaurantSearch
  include ActiveModel::Model
  attr_accessor :query, :location

  def initialize(attributes = {})
    super
    @search_service = YelpService
  end

  def results
    if search_service_results
      goodmeat_restaurants = goodmeats_filter(search_service_results)
    end
    goodmeat_restaurants
  end

  private

  def goodmeats_filter(results)
    GoodmeatsFilter.new.filter(results)
  end

  def search_service_results
    @_search_service_results ||= (
      if has_query?
        search.map do |result|
          RestaurantSearchResult.new(result)
        end
      end
    )
  end

  def has_query?
    query.present? || location.present?
  end

  def search_query
    Hash.new.tap do |h|
      h[:query] = query if query.present?
      h[:location] = location if location.present?
      h[:limit] = 40
    end
  end

  def search
    @search_service.search(search_query)
  end
end
