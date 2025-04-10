module LoanPaymentsHelper

  def due_date_status(due_date)
    if due_date < Date.today
      "text-red-500 font-semibold"
    elsif due_date == Date.today
      "text-yellow-500 font-semibold"
    else
      "text-green-500"
    end
  end

  def due_date_label(due_date)
    if due_date < Date.today
      "(Overdue)"
    elsif due_date == Date.today
      "(Due today)"
    end
  end

end
