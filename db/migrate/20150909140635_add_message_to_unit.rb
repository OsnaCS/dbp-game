class AddMessageToUnit < ActiveRecord::Migration
  def change
    add_reference :units, :message, index: true
    add_foreign_key :units, :messages
  end
end
