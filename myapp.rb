# myapp.rb
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'datamapper'
require 'haml'

DataMapper.setup( :default, "sqlite3://db/addressbook.db" )

# Define the Person model
class Person
  include DataMapper::Resource

  property :firstname, String, :key => true
  property :lastname, String
  property :sport, String
  property :email, String
end

# Automatically create the tables if they don't exist
DataMapper.auto_migrate!

# DataMapper.auto_upgrade!

set :haml, :format => :html5

get '/:name' do
  name = params[:name]
  person = Person.first_or_create(:firstname => name)
  person.firstname = name
  person.lastname = 'Rocci'
  person.email = 'hotmale@hotmail.com'
  person.sport = 'climbing'
  person.save
  person.to_json
end

get '/' do
  people = Person.all
  haml :index, :locals => {
    :people => people
  }
end



