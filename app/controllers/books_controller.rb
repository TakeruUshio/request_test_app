class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  def index
    if params[:id].nil?
      @books = Book.all
    else
      @books = Book.find(params[:id])
      @books = add_query_parameter_and_request_header(@books.to_json)
    end
    render json: @books
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    @books = add_query_parameter_and_request_header(@book.to_json)
    render json: @book
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    if @book.save
      @book = add_query_parameter_and_request_header(@book.to_json)
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    if @book.update(book_params)
      @book = add_query_parameter_and_request_header(@book.to_json)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    @book = add_query_parameter_and_request_header(@book.to_json)
    render json: @book
  end

  private

  def book_params
    params.require(:book).permit(:title)
  end

  def add_query_parameter_and_request_header(response)
    param = JSON.parse(response)
    param["response"] = params["response"]
    param["http_production_version"] = request.headers['HTTP_X_PRODUCTION_VERSION']
    param
  end
end

