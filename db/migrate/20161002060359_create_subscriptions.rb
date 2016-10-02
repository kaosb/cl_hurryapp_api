class CreateSubscriptions < ActiveRecord::Migration[5.0]
	def change
		create_table :subscriptions do |t|
			t.integer :user_id, null: true
			t.integer :partner_id, null: true
			t.timestamps
			t.boolean :status, default: 1, null: true
		end
		add_index :subscriptions, [:user_id, :partner_id]
	end
end
