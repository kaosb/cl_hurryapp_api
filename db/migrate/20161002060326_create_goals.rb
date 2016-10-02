class CreateGoals < ActiveRecord::Migration[5.0]
	def change
		create_table :goals do |t|
			t.integer :partner_id, null: true
			t.string :name, null: true
			t.text :description, null: true
			t.integer :purpose, null: true
			t.integer :purpose_quantity, null: true
			t.string :category, null: true
			t.timestamp :start_at, null: true
			t.timestamp :end_at, null: true
			t.string :time_window_category, null: true
			t.timestamps
			t.boolean :status, default: 1, null: true
		end
		add_index :goals, [:purpose, :category, :time_window_category]
	end
end
