class YelpService
  DEFAULT_LOCATION_DISTANCE = 10_000
  SORT_BY_BEST_FIT_CODE = 0
  SORT_BY_BEST_DISTANCE_CODE = 1
  SORT_BY_BEST_RATING_CODE = 2
  DEFAULT_RESULTS_LIMIT = 20
  REQUIRED_METHODS = %i(
    name
    id
    location
    phone
  ).freeze

  attr_reader :query, :location, :limit, :offset

  def initialize(query)
    @query = query[:query]
    @location = query[:location]
    @limit = query[:limit] || DEFAULT_RESULTS_LIMIT
    @offset = calculate_offset(query[:offset])
  end

  def self.search(query)
    new(query).search
  end

  def calculate_offset(offset)
    result = nil
    if offset
     result = offset * 40
    end
    result
  end

  def search
    search_response.businesses.map do |business|
      parse(business) if business_valid?(business)
    end.compact
  end

  private

  def business_valid?(business)
    if has_required_methods?(business.methods) &&
       location_valid?(business.location)
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
    location.display_address && location.coordinate
  end

  def search_response
    client.search(location, search_params, locale)
  end

  def search_params
    Hash.new.tap do |h|
      h[:term] = query if query
      h[:category_filter] = category
      h[:limit] = limit
      h[:sort] = sort_code
      h[:offset] = offset if offset
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
      name: business.name,
      api_id: business.id,
      display_address: business.location.display_address,
      coordinate: {
        latitude: business.location.coordinate.latitude,
        longitude: business.location.coordinate.longitude
      },
      phone: business.phone
    }
  end

  def client
    Yelp::Client.new(consumer_key: ENV.fetch("YELP_CONSUMER_KEY"),
                     consumer_secret: ENV.fetch("YELP_CONSUMER_SECRET"),
                     token: ENV.fetch("YELP_TOKEN"),
                     token_secret: ENV.fetch("YELP_TOKEN_SECRET"))
  end

  def locale
    { lang: "en" }
  end

  def category
    "restaurants"
  end
end
