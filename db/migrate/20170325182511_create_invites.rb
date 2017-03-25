class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :trip, index: true, foreign_key: true
      t.integer :host_id
      t.string :token
      t.string :email

      t.timestamps null: false
    end
  end
end
