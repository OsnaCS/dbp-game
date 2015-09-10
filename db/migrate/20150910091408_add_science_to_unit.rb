class AddScienceToUnit < ActiveRecord::Migration
  def change
    add_reference :units, :science_one, references:  :science, index: true
    add_reference :units, :science_two, references:  :science, index: true
  end
end
