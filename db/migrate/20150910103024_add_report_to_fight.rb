class AddReportToFight < ActiveRecord::Migration
  def change
    add_column :fights, :report, :text
  end
end
