class Attempt < ActiveRecord::Base
  belongs_to :ord, :touch => :last_shown_at
  validates :successful, :inclusion => { in: [true, false] }
  validates :ord_id, :presence => true
  validates :body, :presence => true
end
