class CreateUsers < ActiveRecord::Migration[5.0]
	def change
		create_table :users do |t|
			t.string :first_name, null: true
			t.string :last_name, null: true
			t.string :nick_name, null: true
			t.string :email, null: true
			t.string :password, null: true
			t.string :token, null: true
			t.string :deviceid, null: true
			t.string :device, null: true
			t.string :gender, null: true
			t.string :age, null: true
			t.string :height, null: true
			t.string :weight, null: true
			t.string :purpose, null: true
			t.string :purpose_unit, null: true
			t.string :purpose_quantity, null: true
			t.string :image_url, null: true
			t.timestamps
			t.boolean :status, default: 1, null: true
		end
		add_index :users, [:nick_name, :email, :token]
	end
end
