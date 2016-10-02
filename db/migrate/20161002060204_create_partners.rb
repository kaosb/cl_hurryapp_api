class CreatePartners < ActiveRecord::Migration[5.0]
	def change
		create_table :partners do |t|
			t.string :name, null: true
			t.text :description, null: true
			t.string :type, null: true
			t.integer :purpose_category, null: true
			t.string :speciality, null: true
			t.string :contact_type, null: true
			t.string :contact_info, null: true
			t.text :image_url, null: true
			t.timestamps
			t.boolean :status, default: 1, null: true
		end
		add_index :partners, [:name, :type, :purpose_category]
	end
end
