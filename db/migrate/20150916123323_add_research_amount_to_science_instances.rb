class AddResearchAmountToScienceInstances < ActiveRecord::Migration
  def change
    add_column :science_instances, :research_amount, :integer
  end
end
