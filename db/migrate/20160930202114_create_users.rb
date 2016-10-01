class CreateUsers < ActiveRecord::Migration[5.0]
	def change
		create_table :users do |t|
			t.string :first_name, null: true
			t.string :last_name, null: true
			t.string :nick_name, null: true
			t.string :email, null: true
			t.string :password, null: true
			t.string :token, null: true
			t.string :device_so, null: true
			t.integer :gender, null: true
			t.integer :age, null: true
			t.decimal :height, null: true
			t.decimal :weight, null: true
			t.integer :purpose, null: true
			t.integer :purpose_quantity, null: true
			t.text :image_url, null: true
			t.timestamps
			t.boolean :status, default: 1, null: true
		end
		add_index :users, [:nick_name, :email, :token]
	end
end
