class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
			t.string	:first_name
			t.string	:last_name
			t.date		:date_of_birth
			t.string	:email, index: { unique: true }
			t.string	:username
			t.string	:password_digest

      t.timestamps
    end
  end
end
