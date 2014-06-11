module ApplicationHelper

  def sanitize_integer(number)
    number.to_s.gsub(/[(\$)|(,)]/, '').to_i
  end

  def sanitize_float(number)
    number.to_s.gsub(/[(\$)|(,)|(%)|(.)]/, '').to_f/100
  end

end
