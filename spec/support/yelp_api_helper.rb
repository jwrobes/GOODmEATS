module YelpApiHelper

  def stub_yelp_api_request
    stub_request(:get, "https://api.yelp.com/v2/search?category_filter=restaurants&lang=en&limit=20&location=94611&sort=0&term=Park%20burger").
      to_return(:status => 200, :body => yelp_response.to_json, :headers => {})
  end

  def stub_yelp_api_request_with_invalid_restaurant_result
    stub_request(:get, "https://api.yelp.com/v2/search?category_filter=restaurants&lang=en&limit=20&location=94611&sort=0&term=Park%20burger").
      to_return(:status => 200, :body => yelp_response_for_invalid_result.to_json, :headers => {})
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
        # "coordinate": {
        #   "latitude": 37.8072590528299,
        #   "longitude": -122.222015729986
        # },
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
    "coordinate": {
      "latitude": 37.8072590528299,
      "longitude": -122.222015729986
    },
    "state_code": "CA"
    }
    }
  end
end
