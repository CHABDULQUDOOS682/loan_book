class BookLoansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan_book, only: [:show, :edit, :update, :destroy ]
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
      @loan_book.loan_book_users.create(user: current_user, access_level: "admin")
      redirect_to @loan_book, notice: "Loan book was successfully created."
    else
      redirect_to new_book_loan_path, notice: "Book name should be unique."
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

  private

  def set_loan_book
    @loan_book = current_user.book_loans.find_by(id: params[:id]) || current_user.shared_loan_books.find_by(id: params[:id])
    redirect_to root_path, alert: "Not authorized" unless @loan_book
  end

  def loan_book_params
    params.require(:book_loan).permit(:name)
  end
end
