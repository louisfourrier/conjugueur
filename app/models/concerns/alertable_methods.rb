module AlertableMethods
  extend ActiveSupport::Concern
  
  # Module that is added to all the class that need an alert system reporting errors.
  # Add an alerts has_many associations
  included do
    has_many :alerts, as: :alertable, dependent: :destroy
  end
  
  def get_alerts
    return self.alerts
  end
  
  def has_alert?
    return !self.alerts.empty?
  end
  
  def add_alert(description)
    self.alerts.create(:description => description)
  end
  
  def clear_alerts
    self.alerts.destroy_all
  end
  
  module ClassMethods
    
    def clear_all_alerts
      self.find_each do |instance| 
        instance.clear_alerts
      end
    end
    
  #--- Scope methods-----------
    # Scope for all instances without alerts
    def without_alerts
      self.includes(:alerts).where("alerts.id" => nil)
    end
    
    # Scope for all instances with alerts
    def with_alerts
      self.joins(:alerts)
    end
    
  end
  
end