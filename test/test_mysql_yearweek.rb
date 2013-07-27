# encoding=utf-8
require 'test/unit'
require 'time'
require 'mysql'
require 'mysql_yearweek'


class MySQLYearweekTest < Test::Unit::TestCase

  def days_in_month(year, month)
    Date.new(year, month, -1).day
  end

  def test_yearweek
    db = Mysql::new('localhost', 'root', '', 'test')
  
    (2011..2100).each do |year|
      (1..12).each do |month|
        (1..days_in_month(year, month)).each do |day|
          (4..4).each do |mode|
          #(0..7).each do |mode|
            sql = "SELECT yearweek('#{year}-#{month}-#{day}', #{mode})"
            official_yearweek = db.query(sql).to_a.flatten[0]
            date = Date.new(year, month, day)

            assert_equal official_yearweek, MySQLYearweek.yearweek(date, mode)
          end
        end 
      end
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
    MySQLYearweek.yearweek(Date.today, 4)
    assert_raise ArgumentError do
      MySQLYearweek.yearweek(Date.today, 0)
    end
  end
end
