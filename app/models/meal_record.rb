class MealRecord < ApplicationRecord

  belongs_to :user

  validates :breakfast_cost, :lunch_cost, :dinner_cost,
            :snack_cost, :something_cost, :track_date, presence: true

end