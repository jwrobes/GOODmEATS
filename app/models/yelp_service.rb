require "http"

class YelpService
  DEFAULT_LOCATION_DISTANCE = 10_000
  SORT_BY_BEST_FIT_CODE = "best_match".freeze
  SORT_BY_BEST_DISTANCE_CODE = "distance".freeze
  SORT_BY_BEST_RATING_CODE = 2
  DEFAULT_RESULTS_LIMIT = 50
  REQUIRED_METHODS = %w(
    name
    id
    location
    phone
  ).freeze

  attr_reader :query, :location, :limit

  def initialize(query)
    @query = query[:query]
    @location = query[:location]
    @limit = query[:limit] || DEFAULT_RESULTS_LIMIT
  end

  def self.search(query)
    new(query).search
  end

  def search
    search_response["businesses"].map do |business|
      parse(business) if business_valid?(business)
    end.compact
  end

  private

  def business_valid?(business)
    if has_required_methods?(business.keys) &&
       location_valid?(business["location"]) &&
       coordinates_valid?(business["coordinates"])
      true
    else
      false
    end
  end

  def has_required_methods?(methods)
    required_keys = REQUIRED_METHODS.clone
    (required_keys & methods).count == 4
  end

  def location_valid?(location)
    location["display_address"]
  end

  def coordinates_valid?(coordinates)
    coordinates && (coordinates&.keys & %w(longitude latitude)).count == 2
  end

  def search_response
    client.search(search_params)
  end

  def search_params
    Hash.new.tap do |h|
      h[:term] = query if query
      h[:categories] = category
      h[:limit] = limit
      h[:location] = location
      h[:locale] = locale
      h[:sort_by] = sort_code
    end
  end

  def sort_code
    if location && !query
      SORT_BY_BEST_DISTANCE_CODE
    else
      SORT_BY_BEST_FIT_CODE
    end
  end

  def parse(business)
    {
      name: business["name"],
      api_id: business["id"],
      display_address: business["location"]["display_address"],
      coordinate: {
        latitude: business["coordinates"]["latitude"],
        longitude: business["coordinates"]["longitude"],
      },
      phone: business["phone"]
    }
  end

  def client
    ::YelpClient
  end

  def locale
    "en_US"
  end

  def category
    "restaurants"
  end
end

class YelpClient
  API_HOST = ENV.fetch("YELP_API_HOST")
  SEARCH_PATH = ENV.fetch("YELP_SEARCH_PATH")
  BUSINESS_PATH = ENV.fetch("YELP_BUSINESS_PATH")
  API_KEY = ENV.fetch("YELP_API_KEY")

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def url
    "#{API_HOST}#{SEARCH_PATH}"
  end

  def self.search(params)
    new(params).search
  end

  def search
    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    response.parse
  end
end
