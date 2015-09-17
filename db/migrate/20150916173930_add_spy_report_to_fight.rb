class AddSpyReportToFight < ActiveRecord::Migration
  def change
    add_column :fights, :spy_report, :text
  end
end
