class Orders < ActiveRecord::Migration[5.0]
  def change
  	create_table :orders do |t|
  		t.belongs_to	:merchant, index: true
  		t.belongs_to	:customer, index: true
  		t.belongs_to	:listing
  		t.decimal			:amount
  		t.integer			:status, default: 0
  		t.timestamps	
  	end
  end
end
