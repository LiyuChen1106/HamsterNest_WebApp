class BorrowRatingController < ApplicationController
  before_action :authenticate_user

  def edit
    @borrow_person = UserProfile.find(params[:id])
  end

  def update
    @borrow_person = UserProfile.find(params[:id])
    @b_rating = @borrow_sperson.borrow_rating
    @b_people = @borrow_person.bpeople
    @b_people = @b_people + 1
    @b_rating = (@b_rating + params[:rating]) / @bpeople
    #:borrow_rating => @b_rating
    #:bpeople => @b_people
    if @borrow_person.update(rate_params)
      redirect_to current_user
    else
      render "edit"
    end
  end

  private

  def rate_params
    params.require(:user_profile).permit(:borrow_rating, :bpeople)
  end
end
