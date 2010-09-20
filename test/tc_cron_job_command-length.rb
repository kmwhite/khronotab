class CronJobTest < Test::Unit::TestCase

  context "a CronJob with a single-arg cmd" do
    setup do
      @cronjob = CronJob.add_new('0 0 0 0 0 root ls')
    end

    should "parse user and cmd correctly" do
      assert_equal('root', @cronjob.user,
                   'User parsed incorrectly') &&
      assert_equal('ls', @cronjob.command,
                   'Command parsed incorrectly')
    end
  end

  context "a CronJob with a multi-arg cmd" do
    setup do
      @cronjob = CronJob.add_new('0 0 0 0 0 root grep foo /var/log/bar | cut -d\':\' -f 3 | sort | uniq')
    end

    should "handle complex, multi command lines" do
      assert_equal('root', @cronjob.user,
                   'User parsed incorrectly') &&
      assert_equal('grep foo /var/log/bar | cut -d\':\' -f 3 | sort | uniq', @cronjob.command,
                   'Command parsed incorrectly')
    end
  end
end

