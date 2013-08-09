class Ord < ActiveRecord::Base
validates :english, :presence => true, :uniqueness => true
validates :swedish, :presence => true, :uniqueness => true
end
