class AddUserIdToExpedition < ActiveRecord::Migration
  def change
  	#add_reference :expeditions, :user, index: true
    #add_reference :users, :expedition, index: true
  end
end
