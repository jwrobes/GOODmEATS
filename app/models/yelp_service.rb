class YelpService
  DEFAULT_LOCATION_DISTANCE = 10_000

  attr_reader :query, :location

  def initialize(query)
    @query = query[:query]
    @location = query[:location]
  end

  def self.search(query)
    new(query).search
  end

  def search
    search_response.businesses.map do |business|
      parse(business)
    end
  end

  private

  def search_response
    client.search(location, search_params, locale)
  end

  def search_params
    {
      term: query,
      category_filter: category,
      limit: 20,
      sort: 1
    }
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
