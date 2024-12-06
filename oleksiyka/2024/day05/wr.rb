def semi_monthly(start_date, dd1, dd2)
  pay_date1, pay_date2 = adjust_dates_within_month(dd1, dd2)
  day_in_month1 = pay_date1.day
  day_in_month2 = pay_date2.day

  dates = []
  index = 0
  while dates.size < 24
    current_date1 = pay_date1 + index.months
    if current_date1 >= start_date # if date is in the past - ignore
      if day_in_month1 != current_date1.day && (current_date1.day - day_in_month2).abs <= 14 # if day's number has changed & difference < 14
        if (day_index = dates.find_index(Date.new(current_date1.year, current_date1.month, day_in_month2))) # adjust date
          dates[day_index] = (current_date1 - 14.days)
        end
      end
      dates.push(current_date1)
    end

    current_date2 = pay_date2 + index.months
    if current_date2 >= start_date # if date is in the past - ignore
      if day_in_month2 != current_date2.day && (current_date2.day - day_in_month1).abs <= 14 # if day's number has changed & difference < 14
        if (day_index = dates.find_index(Date.new(current_date2.year, current_date2.month, day_in_month1))) # adjust date
          dates[day_index] = current_date2 - 14.days
        end
      end
      dates.push(current_date2)
    end

    index += 1
  end

  dates
end

def adjust_dates_within_month(date1, date2)
  date1, date2 = [date1, date2].sort
  difference = (date2 - date1).to_i
  return [date1, date2] if difference >= 14

  adjusted_date1 = [date1 - (14 - difference), Date.new(date1.year, date1.month, 1)].max
  adjusted_date2 = [adjusted_date1 + 14, Date.new(date2.year, date2.month, -1)].min

  [adjusted_date1, adjusted_date2]
end

sd = Time.now
dd1 = Date.new(2024,12,15)
dd2 = Date.new(2024,11,30)
p semi_monthly(sd, dd1, dd2)