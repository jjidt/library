require './helper'
require 'pry'

def main_menu
  header

  puts "A > Add Book To Library"
  puts "L > List Books In Library"
  puts "D > Delete a Book"
  puts "AC > Add Copy"
  puts "X > Exit"

  case prompt().upcase
  when 'A'
    add_book
    main_menu
  when 'L'
    list_books
    main_menu
  when 'D'
    delete_book
    main_menu
  when 'AC'
    list_books
    add_copy
    main_menu
  when 'X'
    exit
  else
    main_menu
  end
end

def add_book
  ws
  title = prompt("What is the title of the book?")
  ws
  author_names = prompt("Who are the book's authors? (split authors by comma ie. bob, jeff, steve)").split(',')
  book_id = Vhs::Book.new('title' => title).create.to_i
  author_ids = author_names.map do |author_name|
    Vhs::Author.new('name' => author_name).create.to_i
  end
  Vhs::Copy.new('book_id' => book_id).create
  author_ids.each do |author_id|
    Vhs::Authors_book.new('book_id' => book_id, 'author_id' => author_id).create
  end
  puts title + " added!"
  sleep 1.5
  clear
end

def delete_book
  ws
  list_books
  title = prompt("What is the title of the book to delete?")
  ws
  if Vhs::Book.read('title' => title).length < 1
    puts "title not found"
  else
    Vhs::Book.delete('title' => title)
    puts title + " deleted!"
  end
  sleep 1.5
  clear
end

def list_books
  Vhs::Book.list.each do |book|
    print "\n" + "Title:  " + book.title + "   by:   "
    authors = Vhs::Author.join_by_name({'right_table' => 'books', 'join_table' => 'authors_books', 'name' => book.title}, 'title')
    authors.each { |author| print author.name + " "}
    book_id = book.id
    print "  copies:  "
    copies = Vhs::Copy.read('book_id' => book_id)
    print copies.length
    ws
  end
end

def add_copy
  title = prompt("Title of copy to add?")
  if book_exists?('title' => title)
    book_id = Vhs::Book.read('title' => title).first.id
    Vhs::Copy.new('book_id' => book_id).create
    puts "added copy of " + title
  else
    puts "Title not found"
  end
  sleep 1.5
  clear
end

def book_exists?(attributes)
  Vhs::Book.read(attributes).length > 0
end

clear

main_menu
