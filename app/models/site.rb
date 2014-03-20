class Site < ActiveRecord::Base
  validates :title, :description, :location, :price, :size, :presence => true

  belongs_to(
    :owner,
    :foreign_key => :user_id,
    :class_name => "User"
  )
end
