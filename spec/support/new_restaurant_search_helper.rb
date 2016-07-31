module NewRestaurantSearchHelper
  def parsed_result
    {
      name: "Park Burger",
      api_id: "park-burger-oakland",
      display_address: ["4218 Park Blvd", "Glenview", "Oakland, CA 94602"],
      coordinate: {
        latitude: 37.8072590528299,
        longitude: -122.222015729986
      },
      phone: "5104791402"
    }
  end

  def new_restaurant_result
    OpenStruct.new(parsed_result)
  end
end
