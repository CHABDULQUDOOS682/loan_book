class BookLoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan_book, only: [:show, :edit, :update, :destroy, :add_user]

  def index
    @loan_books = current_user.book_loans + current_user.shared_loan_books
  end

  def show
    @loan_payments = @loan_book.loan_payments
    @loan_book_user = LoanBookUser.new
  end

  def new
    @loan_book = current_user.book_loans.new
  end

  def create
    @loan_book = current_user.book_loans.new(loan_book_params)

    if @loan_book.save
      redirect_to @loan_book, notice: "Loan book was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @loan_book.update(loan_book_params)
      redirect_to @loan_book, notice: "Loan book was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @loan_book.destroy
    redirect_to book_loans_url, notice: "Loan book was successfully destroyed."
  end

  def add_user
    email = params[:loan_book_user][:email]
    user = User.find_or_create_by(email: email) do |u|
      u.password = Devise.friendly_token[0, 20]
      u.name = email.split("@").first
    end

    @loan_book_user = @loan_book.loan_book_users.find_or_initialize_by(user: user)
    @loan_book_user.access_level = params[:loan_book_user][:access_level] || "view"
    if @loan_book_user.save
      redirect_to @loan_book, notice: "User added successfully."
    else
      redirect_to @loan_book, alert: "Error adding user."
    end
  end

  private

  def set_loan_book
    @loan_book = current_user.book_loans.find_by(id: params[:id]) || current_user.shared_loan_books.find_by(id: params[:id])
    redirect_to root_path, alert: "Not authorized" unless @loan_book
  end

  def loan_book_params
    params.require(:book_loan).permit(:name)
  end
end
