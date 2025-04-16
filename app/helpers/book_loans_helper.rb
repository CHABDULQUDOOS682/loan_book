module BookLoansHelper
  def is_admin?
    @loan_book.loan_book_users.find_by(user_id: current_user).access_level == "admin"
  end

  def is_book_owner?
    @loan_book.user == current_user
  end
end
