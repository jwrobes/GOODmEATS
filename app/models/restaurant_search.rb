class RestaurantSearch
  include ActiveModel::Model
  attr_accessor :query, :location

  def initialize(attributes = {})
    super
    @search_service = YelpService
  end

  def results
    search_results = nil
    if search_service_results
      search_results = search_service_results.select(&:has_goodmeat?)
    end
    search_results
  end

  private

  def search_service_results
    @_search_service_results ||= (
      goodmeat_api_id_matcher = GoodmeatApiIdMatcher.new
      if has_query?
        search.map do |result|
          result[:goodmeat_matcher] = goodmeat_api_id_matcher
          SearchServiceResult.new(result)
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

class GoodmeatApiIdMatcher
  def api_ids
    @_api_ids ||=
      Restaurant.order(:api_id).pluck(:api_id)
  end

  def has_matching_api_id?(api_id)
    api_ids.include?(api_id)
  end
end

class SearchServiceResult
  include ActiveModel::Model

  attr_accessor :name, :api_id, :display_address,
                :coordinate, :phone, :goodmeat_matcher

  def initialize(attributes = {})
    super
  end

  def has_goodmeat?
    goodmeat_matcher.has_matching_api_id?(api_id)
  end
end
