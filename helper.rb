require 'pg'
# require 'pry'
require './lib/vhs.rb'

DB = PG.connect(:dbname => 'library')

Vhs.create_classes

def ws
  puts ''
end

def clear
  system('clear')
end

def prompt(text = "")
  print text + " :>  "
  gets.chomp
end

def header
  puts "#######"
  puts "LIBRARY"
  puts "#######"
  ws
end
