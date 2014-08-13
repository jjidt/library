require 'spec_helper'

describe 'Author' do
  it 'is created with a name and stored in the database' do
    test_author = Vhs::Author.new({'name' => 'Walt Whitman'})
    test_author.create
    expect(Vhs::Author.list.first.name).to eq 'Walt Whitman'
  end
end
