class CreateUserAchievedGoals < ActiveRecord::Migration[5.0]
	def change
		create_table :user_achieved_goals do |t|
			t.integer :user_id, null: true
			t.integer :goal_id, null: true
			t.string :reward, null: true
			t.timestamps
		end
	end
end
