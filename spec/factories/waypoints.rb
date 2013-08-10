# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :waypoint, :class => 'Waypoints' do
    trip_id 1
    location_id 1
    arrival_date "2013-05-24 18:17:21"
    departure_date "2013-05-24 18:17:21"
    type ""
  end
end
