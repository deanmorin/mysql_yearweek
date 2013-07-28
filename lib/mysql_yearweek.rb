# encoding=utf-8
require 'time'


class MySQLYearweek
  MIN_ALLOWED_DATE = Date.new(1584, 1, 1).freeze
  MAX_TESTED_DATE = Date.new(3000, 12, 31).freeze

  def self.yearweek(date, mode=4)
    raise TypeError unless date.is_a?(Date)
    if (date < MIN_ALLOWED_DATE)
      raise ArgumentError, "Dates before #{MIN_ALLOWED_DATE} are not allowed"
    end

    case mode
    when 0
      return mode_zero(date)
    when 1
      return mode_one(date)
    when 2
      return mode_two(date)
    when 3
      return mode_three(date)
    when 4
      return mode_four(date)
    when 5
      return mode_five(date)
    when 6
      return mode_six(date)
    when 7
      return mode_seven(date)
    else
      raise ArgumentError, 'Valid modes are from 0 to 7'
    end
  end

  def self.mode_zero(date)
    if (date.sunday?)
      date += 1
    end

    if (last_week_of_year_has_sunday(date.cwyear - 1))
      if (last_week_of_year_has_sunday(date.cwyear - 2))
        last_week_of_prev_year = 52
      else 
        last_week_of_prev_year = 53
      end
      year = date.cweek > 1 ? date.cwyear : date.cwyear - 1
      week = date.cweek > 1 ? date.cweek - 1 : last_week_of_prev_year

      yearweek = "%04d%02d" % [year, week]
    else
      yearweek = "%04d%02d" % [date.cwyear, date.cweek]
    end
 
    yearweek
  end
  private_class_method :mode_zero


  def self.mode_one(date)
    yearweek = "%04d%02d" % [date.cwyear, date.cweek]
  end
  private_class_method :mode_one

  def self.mode_two(date)
    mode_zero(date)
  end
  private_class_method :mode_two

  def self.mode_three(date)
    mode_one(date)
  end
  private_class_method :mode_three

  def self.mode_four(date)
    if (date.sunday?)
      date += 1
    end

    if (Date.new(date.cwyear, 1, 1).thursday?)
      week = date.cweek > 1 ? date.cweek - 1 : 53
      year = week == 53 ? date.cwyear - 1 : date.cwyear

      yearweek = "%04d%02d" % [year, week]
    else
      yearweek = "%04d%02d" % [date.cwyear, date.cweek]
    end

    yearweek
  end
  private_class_method :mode_four

  def self.mode_five(date)
    if (last_week_of_year_has_monday(date.cwyear - 1))
      if (last_week_of_year_has_monday(date.cwyear - 2))
        last_week_of_prev_year = 52
      else 
        last_week_of_prev_year = 53
      end
      year = date.cweek > 1 ? date.cwyear : date.cwyear - 1
      week = date.cweek > 1 ? date.cweek - 1 : last_week_of_prev_year

      yearweek = "%04d%02d" % [year, week]
    else
      yearweek = "%04d%02d" % [date.cwyear, date.cweek]
    end

    yearweek
  end
  private_class_method :mode_five

  def self.mode_six(date)
    mode_four(date)
  end
  private_class_method :mode_six

  def self.mode_seven(date)
    mode_five(date)
  end
  private_class_method :mode_five

  def self.last_week_of_year_has_sunday(year)
    Date.new(year, 12, 28).sunday? or
    Date.new(year, 12, 29).sunday? or
    Date.new(year, 12, 30).sunday? or
    Date.new(year, 12, 31).sunday?
  end
  private_class_method :last_week_of_year_has_sunday

  def self.last_week_of_year_has_monday(year)
    Date.new(year, 12, 29).monday? or
    Date.new(year, 12, 30).monday? or
    Date.new(year, 12, 31).monday?
  end
  private_class_method :last_week_of_year_has_monday
end
