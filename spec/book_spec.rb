require 'spec_helper'

describe 'Book' do
  it 'is initialized with a name' do
    test_book = Vhs::Book.new('name' => 'slaughterhouse 5')
    expect(test_book.name).to eq 'slaughterhouse 5'
  end

  it 'can be saved into the database' do
    test_book = Vhs::Book.new('title' => 'slaughterhouse 5')
    test_book.create
    expect(Vhs::Book.list.first.title).to eq 'slaughterhouse 5'
  end

  it 'returns an id when saved into the database' do
    test_book = Vhs::Book.new('title' => 'slaughterhouse 5')
    test_book_id = test_book.create
    expect(Vhs::Book.list.first.id.to_i).to eq test_book_id
  end
end
