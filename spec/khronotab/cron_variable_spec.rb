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
