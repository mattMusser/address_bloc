require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
      if name < entry.name
        break
      end
      index+= 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)

    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  def binary_search(name)
    lower = 0 # Save the index of the leftmost item in the array
    upper = entries.length - 1 # Save the index of the rightmost item in the array

    while lower <= upper
      mid = (lower + upper) / 2 # Find and store the middle index
      mid_name = entries[mid].name # Retrieve the name of the entry at the middle index
      #4
      if name == mid_name # == makes the search case sensitive
        return entries[mid]
      elsif name < mid_name # If name is alphbetically before mid_name
        upper = mid - 1 # <== Set this because the name must be in the lower half of the array
      elsif name > mid_name # if name is alphbetically after mid_name
        lower = mid + 1 # <== Set this because the name must be in the upper half of the array
      end
    end
    return nil # If we divide and conquer to the point where no match is found, return nil.
  end

  def iterative_search(name)
    AddressBook.entries.each do |entry|
      if name == entry
        return entry
      else
        return nil
      end
    end
  end
end
