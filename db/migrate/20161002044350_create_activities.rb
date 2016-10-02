class CreateActivities < ActiveRecord::Migration[5.0]
	def change
		create_table :activities do |t|
			t.integer :user_id, null: true
			t.integer :calories, null: true
			t.integer :steps, null: true
			t.date :date, null: true
			t.timestamps
		end
	end
end
