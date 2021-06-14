class ApartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :apartment_not_found

    before_action :find_apartment, only: [:show, :update, :destroy]

    def index
        apartments = Apartment.all
        render json: apartments
    end

    def show
        render json: @apartment
    end

    def update
        @apartment.update(apartment_params)
        render json: @apartment, status: :accepted
    end

    def destroy
        @apartment.destroy
        render status: :accepted
    end

    def create
        new_apartment = Apartment.create(apartment_params)
        render json: new_apartment, status: :created
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def apartment_not_found
        render json: {error: "Apartment not found"}, status: :not_found
    end

    def find_apartment
        @apartment = Apartment.find(params[:id])
    end
end
