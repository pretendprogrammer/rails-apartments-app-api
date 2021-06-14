class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :tenant_not_found

    before_action :find_tenant, only: [:show, :update, :destroy]

    def index
        tenants = Tenant.all
        render json: tenants
    end

    def show
        render json: @tenant
    end

    def update
        @tenant.update(tenant_params)
        render json: @tenant, status: :accepted
    end

    def destroy
        @tenant.destroy
        render status: :accepted
    end

    def create
        new_tenant = Tenant.create(tenant_params)
        render json: new_tenant, status: :created
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def tenant_not_found
        render json: {error: "Tenant not found"}, status: :not_found
    end

    def find_tenant
        @tenant = Tenant.find(params[:id])
    end
end
