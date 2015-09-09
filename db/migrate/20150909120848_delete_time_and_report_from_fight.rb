class DeleteTimeAndReportFromFight < ActiveRecord::Migration
  def change
    remove_column :fights, :time
    remove_column :fights, :report
  end
end
