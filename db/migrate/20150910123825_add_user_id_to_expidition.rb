class AddUserIdToExpidition < ActiveRecord::Migration
  def change
  	#add_reference :expiditions, :user, index: true
    #add_reference :users, :expedition, index: true
  end
end
