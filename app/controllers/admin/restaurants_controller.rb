module Admin
  class RestaurantsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # simply overwrite any of the RESTful actions. For example:

    def new
      @new_restaurant = new_restaurant
      @restaurant = Restaurant.new
      super
    end

    def create
      @restaurant = build_restaurant
      if @restaurant.save
        flash[:notice] = "Restaruant added!"
      else
        flash[:error] = "Error in adding restaruant!"
      end
      redirect_to admin_restaurants_path
    end

    # def index
    #   super
    #   @resources = Restaurant.all.paginate(10, params[:page])
    # end
    private

    def build_restaurant
      Restaurant.new(restaurant_params)
    end

    def new_restaurant
      OpenStruct.new(new_restaurant_params)
    end

    def restaurant_params
      params[:restaurant][:display_address] = display_address_to_array
      params.require(:restaurant).permit!
    end

    def display_address_to_array
      params[:restaurant][:display_address].split("^^")
    end

    def new_restaurant_params
      params.require(:result).permit!
    end
    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Restaurant.find_by!(slug: param)
    # end

    # See https://administrate-docs.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
