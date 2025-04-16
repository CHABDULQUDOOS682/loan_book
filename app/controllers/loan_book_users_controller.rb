# app/controllers/loan_book_users_controller.rb
class LoanBookUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_loan_book

  def create
    if params[:loan_book_user][:email].present?
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
    else
      redirect_to @loan_book, alert: "Email must be present."
    end
  end

  def destroy
    @loan_book_user = @loan_book.loan_book_users.find(params[:id])
    @loan_book_user.destroy
    redirect_to @loan_book, notice: "User removed successfully."
  end

  private

  def set_loan_book
    @loan_book = current_user.book_loans.find(params[:book_loan_id])
  end
end
