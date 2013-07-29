# mysql_yearweek

A gem for getting the exact same yearweek as returned by the MySQL function.

## Overview

MySQL's `yearweek` function has eight different modes for determining the yearweek. This will get the same yearweek for each mode, with `4` being the default mode.

This gem was tested against MySQL 5.6.12.

## Installation

    $ gem install mysql_yearweek

## Example Usage

    > require mysql_yearweek
    => true
    > MySQLYearweek.yearweek(Date.new(2013, 07, 25))
    => "201330"
    > MySQLYearweek.yearweek(Date.new(2013, 07, 25), 2)
    => "201329"
    
## Limitations

This only works with `1584-01-01` and later. Before that be Julian calendar dragons.

## MySQL Yearweek Modes
The following table from the [official MySQL docs] describes how each mode is expected to behave.

<table>
  <tr><th>Mode</th><th>First day of week</th><th>Range</th><th>Week 1 is the first week …</th></tr>
  <tr><td>0</td><td>Sunday</td><td>0-53</td><td>with a Sunday in this year</td></tr>
  <tr><td>1</td><td>Monday</td><td>0-53</td><td>with more than 3 days this year</td></tr>
  <tr><td>2</td><td>Sunday</td><td>1-53</td><td>with a Sunday in this year</td></tr>
  <tr><td>3</td><td>Monday</td><td>1-53</td><td>with more than 3 days this year</td></tr>
  <tr><td>4</td><td>Sunday</td><td>0-53</td><td>with more than 3 days this year</td></tr>
  <tr><td>5</td><td>Monday</td><td>0-53</td><td>with a Monday in this year</td></tr>
  <tr><td>6</td><td>Sunday</td><td>1-53</td><td>with more than 3 days this year</td></tr>
  <tr><td>7</td><td>Monday</td><td>1-53</td><td>with a Monday in this year</td></tr>
</table>

## Copyright

Copyright (c) 2013 Dean Morin. See [LICENSE] for details.

[official MySQL docs]: https://dev.mysql.com/doc/refman/5.0/en/date-and-time-functions.html#function_week
[LICENSE]: https://github.com/deanmorin/mysql_yearweek/blob/master/LICENSE
