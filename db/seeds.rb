Faker::UniqueGenerator.clear

user = {}
user["password"] = "pa55word"
user["password_confirmation"] = 'pa55word'

ActiveRecord::Base.transaction do
  10.times do 
		first_name = Faker::Name.first_name
    last_name = Faker::Name.unique.last_name
    user["first_name"] = first_name
    user["last_name"] = last_name
    user["email"] = "#{first_name[0].downcase}.#{last_name.downcase}@gmail.com"
    user["username"] = Faker::Pokemon.name.underscore
    user["date_of_birth"] = Faker::Date.between(50.years.ago, 15.years.ago)

    User.create(user)
  end
end

listing = {}
user_ids = []
User.all.each { |user| user_ids << user.id }

ActiveRecord::Base.transaction do
  40.times do 
    listing["product"] = Faker::Commerce.product_name
    listing["category"] = Faker::Commerce.department(1, true)
    listing['price'] = Faker::Commerce.price
    listing['description'] = Faker::Hipster.sentence
    listing['user_id'] = user_ids.sample

    Listing.create(listing)
  end
end
