# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    user_id     1
    title       "mah backyard"
    description "some stuff, grass lawn, quiet neighborhood"
    price       20
    size        2
    location    "1234 Market Street, SF, CA"
  end
end
