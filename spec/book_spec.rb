require 'spec_helper'

describe 'Book' do
  it 'is initialized with a title' do
    test_book = Vhs::Book.new('title' => 'slaughterhouse 5')
    expect(test_book.title).to eq 'slaughterhouse 5'
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

  describe '.list' do
    it 'lists all books in the database' do
      test_book = Vhs::Book.new('title' => 'slaughterhouse 5')
      test_book2 = Vhs::Book.new('title' => 'galapagos')
      test_book.create
      test_book2.create
      expect(Vhs::Book.list.length).to eq 2
    end
  end
end
