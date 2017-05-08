class VisitorAppController < ApplicationController
  def index
    @visitor_app_controller = { name: "Stranger" }
  end
end
