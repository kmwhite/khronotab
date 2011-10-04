require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'tempfile'

describe Khronotab::CronComment do

  describe 'with valid cron entries' do
    before do
      @comment = Khronotab::CronComment.matches?('    # FooBarBaz')
    end
    it 'should match good data' do
      @comment.should == true
    end
  end

  describe 'with invalid cron entries' do
    before do
      @comment = Khronotab::CronComment.matches?('lksajdlkjsalkjda')
    end
    it 'should reject bad data' do
      @comment.should == false
    end
  end

  describe 'when creating anew' do

    describe 'without data' do
      it 'should raise an exception' do
        lambda {Khronotab::CronComment.new}.should raise_error
      end
    end

    describe 'with data' do
      before(:each) do
        @str = '  #;asd;laskdasd'
        @comment = Khronotab::CronComment.new(@str)
      end
      it 'should use data' do
        @comment.comment.should == @str
      end
      it 'should become a cron line' do
        @comment.to_line.should == @str
      end
      it 'should become a string' do
        @comment.to_s.should == @str
      end
    end

  end

  describe 'when parsing a line' do

    describe 'with valid data' do
      before do
        @comment = Khronotab::CronComment.parse_new('#foo')
      end
      it 'should parse correctly' do
        @comment.comment.should == '#foo'
      end
    end

    describe 'with invalid data' do
      before do
        @comment = Khronotab::CronComment.parse_new('asdasd')
      end
      it 'should raise an exception' do
        lambda {Khronotab::CronComment.new}.should raise_error
      end
    end

  end

end

describe Khronotab::CronJob do
  before do
    @cronjob = Khronotab::CronJob.new
  end
end

describe Khronotab::CronTab do

  describe 'when created new' do

    before do
      @crontab = Khronotab::CronTab.new
    end

    it 'should have no lines' do
      @crontab.lines.should == []
      @crontab.jobs.should == []
      @crontab.comments.should == []
      @crontab.variables.should == []
    end

    it 'should understand line types' do
      @crontab.determine_line_type('0 0 0 0 0 kmwhite ls').should == Khronotab::CronJob
      @crontab.determine_line_type('FOO="Bar"').should == Khronotab::CronVariable
      @crontab.determine_line_type('#This is a comment').should == Khronotab::CronComment
      @crontab.determine_line_type('').should == Khronotab::CronComment
      @crontab.determine_line_type("\t").should == Khronotab::CronComment
      @crontab.determine_line_type(" ").should == Khronotab::CronComment
      lambda{ @crontab.determine_line_type('asd') }.should raise_error
    end
  end

  describe 'when read from a file' do

    before do
      fname = File.expand_path(File.dirname(__FILE__) + '/sample/crontab')
      @crontab = Khronotab::CronTab.read_from_file(fname)
    end

    it 'should match the source' do
      @crontab.is_a?(Khronotab::CronTab).should be_true
    end

  end

  describe 'when written to a file' do

    before do
      @old_file = File.expand_path(File.dirname(__FILE__) + '/sample/crontab')
      @new_file = Tempfile.new('khronotab')
      @crontab  = Khronotab::CronTab.read_from_file(@old_file)
    end

    it 'can write to disk' do
      lambda{@crontab.write_to_file(@new_file.path)}.should_not raise_error
    end

    pending 'should be in the correct order' do
      File.open(@old_flie).readlines.join('|').should ==
        File.open(@new_file.path).readlines.join('|')
    end

    after do
      @new_file.close!
    end

  end

end

describe Khronotab::CronUnit do
  describe 'when created new' do
  end
end

describe Khronotab::CronVariable do

  describe 'with valid cron entries' do
    before do
      @variable = Khronotab::CronVariable.matches?('FOO=bar')
    end
    it 'should match cron entries' do
      @variable.should == true
    end
  end

  describe 'with invalid cron entries' do
    before do
      @variable = Khronotab::CronVariable.matches?('alkdsjalkjsd')
    end
    it 'should reject bad data' do
      @variable.should == false
    end
  end

  describe 'when creating anew' do

    describe 'without data' do
      before do
        @variable = Khronotab::CronVariable.new
      end
      it 'should use defaults' do
        @variable.name.should be_nil
        @variable.value.should be_nil
      end
    end

    describe 'with data' do
      before do
        data = { :name => 'foo', :value => 'bar' }
        @variable = Khronotab::CronVariable.new(data)
      end
      it 'should use data' do
        @variable.name.should == 'foo'
        @variable.value.should == 'bar'
      end

      it 'should become a cron line' do
        @variable.to_line.should == 'foo=bar'
      end

      it 'should become a string' do
        @variable.to_s.should == '< CronVariable name: foo, value: \'bar\' >'
      end

    end

  end

  describe 'when parsing a line' do

    describe 'with valid data' do
      before do
        @variable = Khronotab::CronVariable.parse_new('FOO="this is fun!"')
      end
      it 'should parse correctly' do
        @variable.name.should == 'FOO'
        @variable.value.should == '"this is fun!"'
      end
    end

    describe 'with invalid data' do
      before do
        @variable = Khronotab::CronVariable.parse_new('lkjasldkjaslkdjalkjsd')
      end
      it 'should return nil' do
        @variable.should be_nil
      end
    end

  end

end
