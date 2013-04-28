class BooksController < ApplicationController
  # GET /books
  # GET /books.json



 def search
    
    @books = Book.search params[:search]
    if params[:search].blank?
      flash[:notice] = "Invalid search parameters."
      redirect_to books_path and return
    elsif @books.empty?
      flash[:notice] = "No Books Found!"
    else
      flash[:notice] = "#{@books.size} Results Found"
    end
    render 'books/index'
  end



def purchase
    @order = Order.find(params[:order_id])
    @book = Book.find(params[:book_id])
    if @order.status == "shipped"
      flash[:notice] = "Order already shipped."
    else
      @order.books << @book
      flash[:notice] = "Book successfully added to your order!"
    end

    redirect_to order_books_browse_path(@order)
  end


  def return
    @order = Order.find(params[:order_id])
    @book = Book.find(params[:book_id])
    if @order.status == "shipped"
      flash[:notice] = "Order already shipped."
    else
      flash[:notice] = "Book successfully removed from your order!"
      Cart.find_by_order_id_and_book_id(@order.id, @book.id).destroy
    end

    redirect_to order_books_browse_path(@order)
  end




  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @books }
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @book }
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml: @book }
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @books }
      format.json { render json: @books }
    end
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.xml { head :ok }
        format.json { render json: @book, status: :created, location: @book }

      else
        format.html { render action: "new" }
        format.xml { render xml: @book.errors, status: :unprocessable_entity}
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.xml { head :ok }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.xml { render xml: @book.errors, status: :unprocessable_entity}
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.xml { head :ok }
      format.json { head :no_content }
    end
  end
end
