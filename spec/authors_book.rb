require 'spec_helper'

describe 'Authors_book' do
  it 'allows assignment of multiple authors to a book' do
    test_author = Vhs::Author.new('name' => 'Addison')
    test_author2 = Vhs::Author.new('name' => 'Wesely')
    test_book = Vhs::Book.new('title' => 'math book')
    test_book_id = test_book.create
    test_author_id = test_author.create
    test_author2_id = test_author2.create
    Vhs::Authors_book.new('book_id' => test_book_id, 'author_id' => test_author_id).create
    Vhs::Authors_book.new('book_id' => test_book_id, 'author_id' => test_author2_id).create
    expect(Vhs::Authors_book.list.length).to eq 2
    expect(Vhs::Authors_book.list[0].author_id.to_i).to eq test_author_id
  end
end
