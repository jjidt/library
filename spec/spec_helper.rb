require 'rspec'
require 'pg'
require 'pry'
require 'vhs'
require 'authors_book'

DB = PG.connect(:dbname => 'library_test')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
    DB.exec("DELETE FROM checkouts *;")
    DB.exec("DELETE FROM copies *;")
    DB.exec("DELETE FROM patrons *;")
    DB.exec("DELETE FROM authors_books")
  end
end

Vhs.create_classes
