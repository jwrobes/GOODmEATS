module Admin
  class NewRestaurantSearchesController < ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Meat.all.paginate(10, params[:page])
    # end

    def show
      @admin_new_restaurant_search = AdminNewRestaurantSearch.new(restaurant_search_params)
      @results = results
    end

    def create
      redirect_to admin_new_restaurant_searches_path(new_restaurant_search_params)
    end
    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Meat.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
    #
    private

    def restaurant_search_params
      params.permit(:query, :location)
    end

    def new_restaurant_search_params
      params.require(:admin_new_restaurant_search).permit(:query, :location)
    end

    def results
      @admin_new_restaurant_search.results
    end
  end
end
