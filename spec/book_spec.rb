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

  describe '.delete' do
    it 'deletes an item from the database' do
      test_book = Vhs::Book.new('title' => 'slaughterhouse 5')
      test_book2 = Vhs::Book.new('title' => 'galapagos')
      test_book_id = test_book.create
      test_book2_id =test_book2.create
      Vhs::Book.delete('title' => 'slaughterhouse 5')
      expect(Vhs::Book.list.length).to eq 1
      expect(Vhs::Book.list.first.title).to eq 'galapagos'
    end
  end

  describe '.join_by_name' do
    it 'will search for all of the book names for a given author' do
      test_author_id = Vhs::Author.new('name' => 'Vonnegut').create
      test_book_id = Vhs::Book.new('title' => 'Timequake').create
      test_book2_id = Vhs::Book.new('title' => 'Player Piano').create
      test_book3_id = Vhs::Book.new('title' => 'Bluebeard').create
      Vhs::Authors_book.new('book_id' =>test_book_id, 'author_id' => test_author_id).create
      Vhs::Authors_book.new('book_id' =>test_book2_id, 'author_id' => test_author_id).create
      Vhs::Authors_book.new('book_id' =>test_book3_id, 'author_id' => test_author_id).create
      expect(Vhs::Book.join_by_name('right_table' => 'authors', 'join_table' => 'authors_books', 'name' => 'Vonnegut').length).to eq 3
    end
  end
end
