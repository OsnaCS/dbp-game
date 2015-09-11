class AddResearchShipToScienceInstances < ActiveRecord::Migration
  def change
    add_column :science_instances, :research_ship, :integer
  end
end
