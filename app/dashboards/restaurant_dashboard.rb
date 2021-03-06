require "administrate/base_dashboard"

class RestaurantDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    restaurant_sources: Field::HasMany,
    sources: Field::HasMany,
    restaurant_meats: Field::HasMany,
    meats: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    display_address: Field::String.with_options(searchable: false),
    phone: Field::String,
    coordinate: Field::String.with_options(searchable: false),
    api_id: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i(
    name
    sources
    meats
  ).freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i(
    name
    sources
    meats
    id
    created_at
    updated_at
    phone
    api_id
  ).freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i(
    name
    phone
    sources
    meats
  ).freeze

  # Overwrite this method to customize how restaurants are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(restaurant)
    restaurant.name
  end
end
