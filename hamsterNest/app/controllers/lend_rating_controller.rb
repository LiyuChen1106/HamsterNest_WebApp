class LendRatingController < ApplicationController
    before_action :authenticate_user

    def edit
        @lend_person=UserProfile.find(params[:id])
    end
    def update
        @lend_person=UserProfile.find(params[:id])
        @l_rating=@lend_person.borrow_rating
        @l_people=@lend_person.bpeople
        @l_people=@l_people+1
        @l_rating=(@l_rating+params[:rating])/@bpeople
        :borrow_rating => @l_rating
        :bpeople => @l_people
        if @lend_person.update(rate_params)
            redirect_to current_user
        else
            render 'edit'
        end
    end

    private
    def rate_params
        params.require(:user_profile).permit(:lend_rating, :lpeople)
    end



end