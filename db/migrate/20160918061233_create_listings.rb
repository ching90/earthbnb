class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
    	t.string :title
      t.string :kind_of_place
      t.string :types_of_property
    	t.float :rental_price
    	t.string :location
    	t.string :description
    	t.string :photo
    	t.integer :bed, default:1
      t.integer :guest_allowed, default:1
      t.integer :bathroom, default:1
      t.integer :user_id
      t.boolean :safety_amenities

      t.timestamps null: false
    end
  end
end
