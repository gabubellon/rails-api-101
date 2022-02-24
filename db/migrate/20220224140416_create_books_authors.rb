class CreateBooksAuthors < ActiveRecord::Migration[6.1]
  def up
    # create join table
    create_table :books_authors do |t|
      t.references :book, foreign_key: true
      t.references :author, foreign_key: true

      t.timestamps
    end
    # populate join table with existing data
    puts 'populating books_authors'
    Author.all.each do |author|
      puts "#{author.name} is being added to the books_authors table"
      BooksAuthor.create(book_id: author.book_id, author_id: author.id)
      puts "There are #{BooksAuthor.count} books_authors records"
    end
    # remove obsolete column
    puts 'removing old association'
    remove_reference :authors, foreign_key: true
  end

  def down
    # add reference column back
    add_reference :books, :author, foreign_key: true
    # Using a model after changing its table
    # https://api.rubyonrails.org/classes/ActiveRecord/Migration.html#class-ActiveRecord::Migration-label-Using+a+model+after+changing+its+table
    Author.reset_column_information
    # associate book with author, even though it will just be one.
    BooksAuthor.all.each do |book_author|
      Author.find(book_author.author_id).update_attribute(:book_id, book_author.book_id)
    end
    # remove join table
    drop_table :books_authors
  end
end
