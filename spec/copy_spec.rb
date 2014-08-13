require 'spec_helper'

describe 'Copy' do
  it 'is created with a book_id' do
    test_book = Vhs::Book.new('title' => 'Cats Cradle')
    book_id = test_book.create.to_s
    test_copy = Vhs::Copy.new('book_id' => book_id)
    test_copy.create
    expect(Vhs::Copy.list.first.book_id).to eq book_id
  end
end
