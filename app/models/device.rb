class Device < ActiveRecord::Base
	belongs_to :experiment

	def in_experiment?
		if self.experiment #not nil
			return self.experiment.active?
		else
			return false
		end
	end
end
