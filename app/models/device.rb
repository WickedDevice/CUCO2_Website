class Device < ActiveRecord::Base
	validates :encryption_key, presence: true
	validates :experiment_id, numericality: { only_integer: true, allow_nil: true }
	validates :address, uniqueness: true
	validates :name, presence: true

	#validates :user_id, numericality: { only_integer: true }
	belongs_to :experiment # This is the active experiment
	belongs_to :user
	has_many :device_experiments
	has_many :experiments, :through => :device_experiments

	def in_experiment?
		if self.experiment #not nil
			return self.experiment.active?
		else
			return false
		end
	end

	def checkout to_experiment_id
		if self.in_experiment? && (self.experiment_id != to_experiment_id)
			throw "Device #{id} in experiment"
		end
		self.experiment_id = to_experiment_id
		throw "Couldn't save device #{id}" if not self.save
	end

	def checkin experiment_id
		if experiment_id != self.experiment_id
			return true
		else
			self.experiment_id = nil
			return self.save
		end
	end

	 #This is slightly less ugly than the other way to do this
	alias_method :super_update, :update
	private :super_update
	def update(params)
		#Fail if it would change mid-experiment
		if in_experiment? && !params[experiment].nil? && params[experiment] != self.experiment_id
			return false
		end
		super_update(params)
	end

end
