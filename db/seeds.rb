# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

module SeedHelper
  include Faker

  def self.johndoe_email
    'john@doe.com'
  end

  def self.johndoe_password
    'asdfasdf'
  end

  def self.create_johndoe
    puts "Creating confirmed user '#{johndoe_email}' with password '#{johndoe_password}'"

    User.where(
      first_name: "John",
      last_name: "Doe",
      email: johndoe_email).first_or_initialize.tap do |johndoe|
        johndoe.password = johndoe_password
        johndoe.save!
      end
  end
 
  def self.seed
    ActiveRecord::Base.transaction do
      create_johndoe
    end

    puts "Test user '#{johndoe_email}' created with password '#{johndoe_password}'"
  end
end
SeedHelper.seed