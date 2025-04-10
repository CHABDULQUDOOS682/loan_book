class LoanPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan_book
  before_action :set_loan_payment, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_user, except: [ :index, :show ]

  def index
    @loan_payments = @loan_book.loan_payments
  end

  def show
  end

  def new
    @loan_payment = @loan_book.loan_payments.new
  end

  def create
    @loan_payment = @loan_book.loan_payments.new(loan_payment_params)
    @loan_payment.user = current_user

    if @loan_payment.save
      redirect_to [ @loan_book, @loan_payment ], notice: "Loan payment was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @loan_payment.update(loan_payment_params)
      redirect_to [ @loan_book, @loan_payment ], notice: "Loan payment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @loan_payment.destroy
    redirect_to loan_book_loan_payments_url(@loan_book), notice: "Loan payment was successfully destroyed."
  end

  private

  def set_loan_book
    @loan_book = current_user.book_loans.find_by(id: params[:book_loan_id]) || current_user.shared_loan_books.find_by(id: params[:book_loan_id])
    redirect_to root_path, alert: "Not authorized" unless @loan_book
  end

  def set_loan_payment
    @loan_payment = @loan_book.loan_payments.find(params[:id])
  end

  def loan_payment_params
    params.require(:loan_payment).permit(
      :amount, :given_by, :given_to, :witness,
      :given_date, :due_date, :total_receivable,
      :received_amount, :notes, :document
    )
  end

  def authorize_user
    unless @loan_book.user == current_user || @loan_book.loan_book_users.where(user: current_user, access_level: [ "admin" ]).exists?
      redirect_to root_path, alert: "Not authorized"
    end
  end
end
