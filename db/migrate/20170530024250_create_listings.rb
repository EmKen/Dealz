class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
    	t.belongs_to :user
    	t.string	:product
    	t.text		:description
    	t.string	:category
    	t.decimal	:price, precision: 8, scale:2
    	t.integer	:status, default: 0
      t.timestamps
    end
  end
end
