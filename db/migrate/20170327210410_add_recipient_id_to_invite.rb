class AddRecipientIdToInvite < ActiveRecord::Migration
  def change
    add_column :invites, :recipient_id, :integer
  end
end
