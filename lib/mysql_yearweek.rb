# encoding=utf-8
require 'time'


class MySQLYearweek

  def self.yearweek(date, mode=4)
    raise TypeError unless date.is_a?(Date)
    raise ArgumentError, 'Currently only type 4 is supported' if mode != 4

    mode_four(date)
  end

  def self.mode_four(date)
    if (date.sunday?)
      date += 1
    end

    if (Date.new(date.cwyear, 1, 1).thursday?)
      week = date.cweek > 1 ? date.cweek - 1 : 53
      year = week == 53 ? date.cwyear - 1 : date.cwyear

      "%04d%02d" % [year, week]
    else
      "%04d%02d" % [date.cwyear, date.cweek]
    end
  end
  private_class_method :mode_four
end
