require 'spec_helper'

describe 'Book' do
  it 'is initialized with a name' do
    test_book = Vhs::Book.new('name' => 'slaughterhouse 5')
    expect(test_book.name).to eq 'slaughterhouse 5'
  end
