class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show update destroy]
  
  # GET /authors
  def index
    book = Book.find_by(id: params[:book_id])
    @authors = book ? book.authors : Author.all
    render json: @authors.includes(:book), only: [:name]
  end

  # GET /authors/1
  def show
    render json: @author
  end

  # POST /authors
  def create
    @author = Author.new(book_params)

    if @author.save
      render json: @author, status: :created, location: @book
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @author.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_author
    @author = set_model(Author, params)
  end

  # Only allow a list of trusted parameters through
  def author_params
    params.require(:author).permit(:name)
  end
end
