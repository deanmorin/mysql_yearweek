# encoding=utf-8
require 'date'
require 'test/unit'
require 'mysql'
require 'mysql_yearweek'


class MySQLYearweekTest < Test::Unit::TestCase

  def days_in_month(year, month)
    Date.new(year, month, -1).day
  end

  def test_yearweek
    db = Mysql::new('localhost', 'root', '', 'test')

    low_year = MySQLYearweek::MIN_ALLOWED_DATE.year
    high_year = MySQLYearweek::MAX_TESTED_DATE.year
  
    (low_year..high_year).each do |year|
      [1, 12].each do |month|
        (1..days_in_month(year, month)).each do |day|
          (0..7).each do |mode|
            sql = "SELECT yearweek('#{year}-#{month}-#{day}', #{mode})"
            official_yearweek = db.query(sql).to_a.flatten[0]
            date = Date.new(year, month, day)

            assert_equal official_yearweek, MySQLYearweek.yearweek(date, mode)
          end
        end 
      end
    end
  end

  def test_allowed_dates
    date = Date.new(MySQLYearweek::MIN_ALLOWED_DATE.year, 1, 1)
    MySQLYearweek.yearweek(date)

    assert_raise ArgumentError do
      date = Date.new(MySQLYearweek::MIN_ALLOWED_DATE.year - 1, 12, 31)
      MySQLYearweek.yearweek(date)
    end
  end

  def test_date_classes
    assert_raise TypeError do
      MySQLYearweek.yearweek(1)
    end
    d = Date.today
    dt = DateTime.now
    assert_equal MySQLYearweek.yearweek(d), MySQLYearweek.yearweek(dt)
  end

  def test_type
    (0..7).each do |i|
      MySQLYearweek.yearweek(Date.today, i)
    end
    assert_raise ArgumentError do
      MySQLYearweek.yearweek(Date.today, -1)
    end
    assert_raise ArgumentError do
      MySQLYearweek.yearweek(Date.today, 8)
    end
  end
end
