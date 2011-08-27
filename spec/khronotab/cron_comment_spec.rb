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
