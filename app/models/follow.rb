class Follow < ApplicationRecord
  belongs_to :follower, class_name: "EndUser"
  belongs_to :followee, class_name: "EndUser"
end
