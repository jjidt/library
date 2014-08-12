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

  describe '.read' do
    it 'searches the database for a book by title' do
      test_book = Vhs::Book.new('title' => 'slaughterhouse 5')
      test_book2 = Vhs::Book.new('title' => 'galapagos')
      test_book_id = test_book.create
      test_book2_id =test_book2.create
      expect(Vhs::Book.read('title' => 'galapagos').first.id.to_i).to eq test_book2.id
    end
  end

  describe '.update' do
    it 'changes information in the database' do
      test_book = Vhs::Book.new('title' => 'slaughterhouse 5')
      test_book2 = Vhs::Book.new('title' => 'galapagos')
      test_book_id = test_book.create
      test_book2_id =test_book2.create
      Vhs::Book.update({'title' => 'breakfast of champions'}, {'title' => 'slaughterhouse 5'})
      expect(Vhs::Book.list[1].title).to eq 'breakfast of champions'
    end
  end
end
