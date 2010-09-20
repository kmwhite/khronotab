class CronJobTest < Test::Unit::TestCase

  context "a CronJob with range time args" do
    setup do
      @cronjob = CronJob.add_new('0-9 0-9 0-9 0-9 0-4 root ls')
    end

    should "should have correct user and command" do
      assert_equal('root', @cronjob.user,
                   'User parsed incorrectly') &&
      assert_equal('ls', @cronjob.command,
                   'Command parsed incorrectly')
    end
  end

  context "a CronJob with interval time args" do
    setup do
      @cronjob = CronJob.add_new('6/2 6/2 6/2 6/2 6/2 root ls')
    end

    should "should have correct user and command" do
      assert_equal('root', @cronjob.user,
                   'User parsed incorrectly') &&
      assert_equal('ls', @cronjob.command,
                   'Command parsed incorrectly')
    end
  end

  context "a CronJob with asterisk time args" do
    setup do
      @cronjob = CronJob.add_new('* * * * * root ls')
    end

    should "should have correct user and command" do
      assert_equal('root', @cronjob.user,
                   'User parsed incorrectly') &&
      assert_equal('ls', @cronjob.command,
                   'Command parsed incorrectly')
    end
  end

  context "a CronJob with mixed time args" do
    setup do
      @cronjob = CronJob.add_new('* 6/2 0-9 0 0 root ls')
    end

    should "should have correct user and command" do
      assert_equal('root', @cronjob.user,
                   'User parsed incorrectly') &&
      assert_equal('ls', @cronjob.command,
                   'Command parsed incorrectly')
    end
  end

end

