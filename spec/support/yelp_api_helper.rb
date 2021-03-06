module YelpApiHelper

  API_HOST = ENV.fetch("YELP_API_HOST")
  SEARCH_PATH = ENV.fetch("YELP_SEARCH_PATH")
  API_KEY = ENV.fetch("YELP_API_KEY")

  def yelp_url
    "#{API_HOST}#{SEARCH_PATH}"
  end

  def build_query_params(location: 94611, query: nil , sort_by: "best_match")
    Hash.new.tap do |h|
      h[:term] = query if query
      h[:categories] = "restaurants"
      h[:limit] = 50
      h[:location] = location
      h[:locale] = "en_US"
      h[:sort_by] = sort_by
    end.to_param
  end

  def headers
    {'Authorization'=>"Bearer #{API_KEY}"}
  end

  def stub_yelp_api_request
    stub_request(:get, "https://api.yelp.com/v3/businesses/search?#{build_query_params(query: "Park burger")}").with(headers: headers).
      to_return(:status => 200, :body => yelp_response.to_json, :headers => {"Content-Type"=> "application/json"})
  end

  def stub_yelp_api_request_with_invalid_restaurant_result
    stub_request(:get, "#{yelp_url}?#{build_query_params(query: "Park burger")}").with(headers: headers).
      to_return(:status => 200, :body => yelp_response_for_invalid_result.to_json, :headers => {"Content-Type"=> "application/json"})
  end

  def stub_yelp_api_request_with_one_result_matching_goodmeat_and_one_not
    stub_request(:get, "#{yelp_url}?#{build_query_params(sort_by:"distance")}").with(headers: headers).
      to_return(:status => 200, :body => yelp_response_with_two_restaurants.to_json, :headers => {"Content-Type"=> "application/json"})
  end

  def stub_yelp_api_request_for_zipcode_with_goodmeat_restaurant
    stub_request(:get, "#{yelp_url}?#{build_query_params}").with(headers: headers).
      to_return(:status => 200, :body => yelp_response.to_json, :headers => {"Content-Type"=> "application/json"})
  end

  def yelp_response_with_two_restaurants
    {
      "region": {
        "span": {
          "latitude_delta": 0.11968757081039882,
          "longitude_delta": 0.09974228000001517
        },
        "center": {
          "latitude": 37.81583349285645,
          "longitude": -122.22777439999999
        }
      },
      "total": 1480,
      "businesses": [
        restaurant_result,
        restaurant_result_2
      ]
    }
  end

  def yelp_response
    {
      "region": {
        "span": {
          "latitude_delta": 0.11968757081039882,
          "longitude_delta": 0.09974228000001517
        },
        "center": {
          "latitude": 37.81583349285645,
          "longitude": -122.22777439999999
        }
      },
      "total": 1480,
      "businesses": [
        restaurant_result
      ]
    }
  end

  def yelp_response_for_invalid_result
    {
      "region": {
        "span": {
          "latitude_delta": 0.11968757081039882,
          "longitude_delta": 0.09974228000001517
        },
        "center": {
          "latitude": 37.81583349285645,
          "longitude": -122.22777439999999
        }
      },
      "total": 1480,
      "businesses": [
        invalid_restaurant_result
      ]
    }
  end


  def parsed_restaurant_result
    {
      name: "Park Burger",
      api_id: "park-burger-oakland",
      display_address: [
        "4218 Park Blvd",
        "Glenview",
        "Oakland, CA 94602"
      ],
      coordinate: {
        latitude: 37.8072590528299,
        longitude: -122.222015729986
    },
    phone:  "5104791402"
    }
  end

  def invalid_restaurant_result
    {
      "is_claimed": true,
      "rating": 4.0,
      "mobile_url": "http://m.yelp.com/biz/park-burger-oakland?utm_campaign=yelp_api&utm_medium=api_v2_search&utm_source=cmmBGuS50qHw8t6l6Db-rA",
      "rating_img_url": "https://s3-media4.fl.yelpcdn.com/assets/2/www/img/c2f3dd9799a5/ico/stars/v1/stars_4.png",
      "review_count": 280,
      "name": "Park Burger",
      "rating_img_url_small": "https://s3-media4.fl.yelpcdn.com/assets/2/www/img/f62a5be2f902/ico/stars/v1/stars_small_4.png",
      "url": "http://www.yelp.com/biz/park-burger-oakland?utm_campaign=yelp_api&utm_medium=api_v2_search&utm_source=cmmBGuS50qHw8t6l6Db-rA",
      "categories": [
        [
          "Hot Dogs",
          "hotdog"
        ],
        [
          "American (New)",
          "newamerican"
        ],
        [
          "Burgers",
          "burgers"
        ]
      ],
      "phone": "5104791402",
      "snippet_text": "I loved the map on the inside wall and the seating layout was cute too! Sweet staff, fast service. All the decor just meshed together very well - good...",
      "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/J5VJAaH4rQSKypRdhZHwVA/ms.jpg",
      "snippet_image_url": "http://s3-media3.fl.yelpcdn.com/photo/0vf_wiqZ1TOOxbYmSY4_Ow/ms.jpg",
      "display_phone": "+1-510-479-1402",
      "rating_img_url_large": "https://s3-media2.fl.yelpcdn.com/assets/2/www/img/ccf2b76faa2c/ico/stars/v1/stars_large_4.png",
      "id": "park-burger-oakland",
      "is_closed": false,
      # "coordinate": {
      #   "latitude": 37.8072590528299,
      #   "longitude": -122.222015729986
      # },
      "location": {
        "cross_streets": "Edgewood Ave & Glenfield Ave",
        "city": "Oakland",
        "display_address": [
          "4218 Park Blvd",
          "Glenview",
          "Oakland, CA 94602"
        ],
        "geo_accuracy": 9.5,
        "neighborhoods": [
          "Glenview",
          "Lower Hills"
        ],
        "postal_code": "94602",
        "country_code": "US",
        "address": [
          "4218 Park Blvd"
        ],
        "state_code": "CA"
      }
    }
  end

  def restaurant_result
    {
      "is_claimed": true,
      "rating": 4.0,
      "mobile_url": "http://m.yelp.com/biz/park-burger-oakland?utm_campaign=yelp_api&utm_medium=api_v2_search&utm_source=cmmBGuS50qHw8t6l6Db-rA",
      "rating_img_url": "https://s3-media4.fl.yelpcdn.com/assets/2/www/img/c2f3dd9799a5/ico/stars/v1/stars_4.png",
      "review_count": 280,
      "name": "Park Burger",
      "rating_img_url_small": "https://s3-media4.fl.yelpcdn.com/assets/2/www/img/f62a5be2f902/ico/stars/v1/stars_small_4.png",
      "url": "http://www.yelp.com/biz/park-burger-oakland?utm_campaign=yelp_api&utm_medium=api_v2_search&utm_source=cmmBGuS50qHw8t6l6Db-rA",
      "categories": [
        [
          "Hot Dogs",
          "hotdog"
        ],
        [
          "American (New)",
          "newamerican"
        ],
        [
          "Burgers",
          "burgers"
        ]
    ],
    "phone": "5104791402",
    "snippet_text": "I loved the map on the inside wall and the seating layout was cute too! Sweet staff, fast service. All the decor just meshed together very well - good...",
    "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/J5VJAaH4rQSKypRdhZHwVA/ms.jpg",
    "snippet_image_url": "http://s3-media3.fl.yelpcdn.com/photo/0vf_wiqZ1TOOxbYmSY4_Ow/ms.jpg",
    "display_phone": "+1-510-479-1402",
    "rating_img_url_large": "https://s3-media2.fl.yelpcdn.com/assets/2/www/img/ccf2b76faa2c/ico/stars/v1/stars_large_4.png",
    "id": "park-burger-oakland",
    "coordinates": {
      "latitude": 37.8072590528299,
      "longitude": -122.222015729986
    },
    "is_closed": false,
    "location": {
      "cross_streets": "Edgewood Ave & Glenfield Ave",
      "city": "Oakland",
      "display_address": [
        "4218 Park Blvd",
        "Glenview",
        "Oakland, CA 94602"
    ],
    "geo_accuracy": 9.5,
    "neighborhoods": [
      "Glenview",
      "Lower Hills"
    ],
    "postal_code": "94602",
    "country_code": "US",
    "address": [
      "4218 Park Blvd"
    ],
    "state_code": "CA"
    }
    }
  end

  def restaurant_result_2
    {
      "is_claimed": true,
      "rating": 4.0,
      "mobile_url": "http://m.yelp.com/biz/park-burger-oakland?utm_campaign=yelp_api&utm_medium=api_v2_search&utm_source=cmmBGuS50qHw8t6l6Db-rA",
      "rating_img_url": "https://s3-media4.fl.yelpcdn.com/assets/2/www/img/c2f3dd9799a5/ico/stars/v1/stars_4.png",
      "review_count": 280,
      "name": "Park Burger-2",
      "rating_img_url_small": "https://s3-media4.fl.yelpcdn.com/assets/2/www/img/f62a5be2f902/ico/stars/v1/stars_small_4.png",
      "url": "http://www.yelp.com/biz/park-burger-oakland?utm_campaign=yelp_api&utm_medium=api_v2_search&utm_source=cmmBGuS50qHw8t6l6Db-rA",
      "categories": [
        [
          "Hot Dogs",
          "hotdog"
        ],
        [
          "American (New)",
          "newamerican"
        ],
        [
          "Burgers",
          "burgers"
        ]
      ],
      "phone": "5104791402",
      "snippet_text": "I loved the map on the inside wall and the seating layout was cute too! Sweet staff, fast service. All the decor just meshed together very well - good...",
      "image_url": "https://s3-media2.fl.yelpcdn.com/bphoto/J5VJAaH4rQSKypRdhZHwVA/ms.jpg",
      "snippet_image_url": "http://s3-media3.fl.yelpcdn.com/photo/0vf_wiqZ1TOOxbYmSY4_Ow/ms.jpg",
      "display_phone": "+1-510-479-1402",
      "rating_img_url_large": "https://s3-media2.fl.yelpcdn.com/assets/2/www/img/ccf2b76faa2c/ico/stars/v1/stars_large_4.png",
      "id": "park-burger-oakland-2",
      "is_closed": false,
      "coordinates": {
        "latitude": 37.8072590528299,
        "longitude": -122.222015729986
      },
      "location": {
        "cross_streets": "Edgewood Ave & Glenfield Ave",
        "city": "Oakland",
        "display_address": [
          "4218 Park Blvd",
          "Glenview",
          "Oakland, CA 94602"
        ],
        "geo_accuracy": 9.5,
        "neighborhoods": [
          "Glenview",
          "Lower Hills"
        ],
        "postal_code": "94602",
        "country_code": "US",
        "address": [
          "4218 Park Blvd"
        ],
        "state_code": "CA"
      }
    }
  end
end
