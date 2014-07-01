class Page < ActiveRecord::Base
	validates :title, uniqueness: true
end
