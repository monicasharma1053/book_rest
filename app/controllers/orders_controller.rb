class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json

 def search
    @books = Book.search params[:search]
    @order = Order.find(params[:id])
    if params[:search].blank?
      flash[:notice] = "Invalid search parameters."
      redirect_to order_books_browse_path(@order) and return
    elsif @books.empty?
      flash[:notice] = "No Books Found!"
    else
      flash[:notice] = "#{@books.size} Results Found"
    end
    render 'orders/browse'
  end


  def checkout
    @order = Order.find(params[:order_id])
    if @order.books.empty?
      flash[:notice] = "Sorry. No books to ship!"
    else
      @order.status = "shipped" unless @order.status == "shipped"
      flash[:notice] = "Your books are on their way!"
    end

    redirect_to orders_path if @order.save
  end

  def browse
    @order = Order.find(params[:id])
    @books = Book.all

    respond_to do |format|
      format.html
      format.xml { render xml: [@order, @books]}
      format.json { render json: [ @order, @books ] }
    end
  end



  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @orders}
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render xml: @order}
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml:@order }
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render xml:@order }
      format.json { render json: @order }
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.xml { head :ok }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.xml { render xml: @order.errors, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.xml { head: ok }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.xml { render xml: @order.errors, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    @order.destroy

    respond_to do |format|
      format.html { redirect_to orders_url }
      format.xml { head :ok }
      format.json { head :no_content }
    end
  end
end
