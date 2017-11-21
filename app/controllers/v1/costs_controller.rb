module V1
  class CostsController < ApplicationController
    before_action :set_cost, only: %i[show update destroy]

    # GET /costs
    def index
      @costs = current_user.costs.paginate(page: params[:page], per_page: 20)
      json_response(@costs)
    end

    # POST /costs
    def create
      @cost = current_user.costs.create!(cost_params)
      json_response(@cost, :created)
    end

    # GET /costs/:id
    def show
      json_response(@cost)
    end

    # PUT /costs/:id
    def update
      @cost.update(cost_params)
      head :no_content
    end

    # DELETE /costs/:id
    def destroy
      @cost.destroy
      head :no_content
    end

    private

    def cost_params
      # whitelist params
      params.permit(:title, :description, :code, :amount, :paid)
    end

    def set_cost
      @cost = current_user.costs.find(params[:id])
    end
  end
end
