class CronJobTest < Test::Unit::TestCase

  context "a CronJob" do
    setup do
      @cronjob = CronJob.new
    end

    should "have a nil minutes" do
      assert_nil @cronjob.minutes.cron_form
    end

    should "have a nil hours" do
      assert_nil @cronjob.hours.cron_form
    end

    should "have a nil days_of_month" do
      assert_nil @cronjob.days_of_month.cron_form
    end

    should "have a nil month" do
      assert_nil @cronjob.month.cron_form
    end

    should "have a nil days_of_week" do
      assert_nil @cronjob.days_of_week.cron_form
    end

    should "have a nil user" do
      assert_nil @cronjob.user
    end

    should "have a nil command" do
      assert_nil @cronjob.command
    end

  end
end

