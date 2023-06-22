class MealRecord < ApplicationRecord

  belongs_to :user

  validates :breakfast_cost, :lunch_cost, :dinner_cost,
            :snack_cost, :something_cost, :track_date, presence: true

  def daily_total_cost
   (breakfast_cost + lunch_cost + dinner_cost + snack_cost + something_cost).to_s(:delimited)
  end

end
