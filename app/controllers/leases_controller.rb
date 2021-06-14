class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :lease_not_found

    def create
        new_lease = Lease.create(lease_params)
        render json: new_lease, status: :accepted
    end

    def destroy
        lease = Lease.find(params[:id])
        lease.destroy
        render status: :accepted
    end

    private

    def lease_not_found
        render json: {error: "Lease not found"}, status: :not_found
    end

    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end
end
