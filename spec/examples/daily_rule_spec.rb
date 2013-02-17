require File.dirname(__FILE__) + '/../spec_helper'

module IceCube
  describe DailyRule, 'occurs_on?' do

  it 'should not produce results for @interval = 0' do
    start_date = DAY
    schedule = IceCube::Schedule.new(start_date)
    schedule.add_recurrence_rule IceCube::Rule.daily(0)
    #check assumption
    dates = schedule.occurrences(start_date + 2 * IceCube::ONE_DAY)
    dates.size.should == 0
    dates.should == []
  end

  it 'should produce the correct days for @interval = 1' do
    start_date = DAY
    schedule = IceCube::Schedule.new(start_date)
    schedule.add_recurrence_rule IceCube::Rule.daily
    #check assumption
    dates = schedule.occurrences(start_date + 2 * IceCube::ONE_DAY)
    dates.size.should == 3
    dates.should == [DAY, DAY + 1 * IceCube::ONE_DAY, DAY + 2 * IceCube::ONE_DAY]
  end

    it 'should produce the correct days for @interval = 2' do
      schedule = Schedule.new(t0 = Time.now)
      schedule.add_recurrence_rule Rule.daily(2)
      #check assumption (3) -- (1) 2 (3) 4 (5) 6
      times = schedule.occurrences(t0 + 5 * ONE_DAY)
      times.size.should == 3
      times.should == [t0, t0 + 2 * ONE_DAY, t0 + 4 * ONE_DAY]
    end

    it 'should produce the correct days for @interval = 2 when crossing into a new year' do
      schedule = Schedule.new(t0 = Time.utc(2011, 12, 29))
      schedule.add_recurrence_rule Rule.daily(2)
      #check assumption (3) -- (1) 2 (3) 4 (5) 6
      times = schedule.occurrences(t0 + 5 * ONE_DAY)
      times.size.should == 3
      times.should == [t0, t0 + 2 * ONE_DAY, t0 + 4 * ONE_DAY]
    end

    it 'should produce the correct days for interval of 4 day with hour and minute of day set' do
      schedule = Schedule.new(t0 = Time.local(2010, 3, 1))
      schedule.add_recurrence_rule Rule.daily(4).hour_of_day(5).minute_of_hour(45)
      #check assumption 2 -- 1 (2) (3) (4) 5 (6)
      times = schedule.occurrences(t0 + 5 * ONE_DAY)
      times.should == [
        t0 + 5 * ONE_HOUR + 45 * ONE_MINUTE,
        t0 + 4 * ONE_DAY + 5 * ONE_HOUR + 45 * ONE_MINUTE
      ]
    end

  end
end
