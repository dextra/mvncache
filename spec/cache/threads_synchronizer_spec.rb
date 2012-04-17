require 'spec_helper'

module Cache
  describe ThreadsSynchronizer do
    
    describe ".get_mutex_for_key" do

      it "returns same mutex for same key" do
        synchronizer = ThreadsSynchronizer.new
        
        m1_a = synchronizer.get_mutex_for_key('1')
        m2_a = synchronizer.get_mutex_for_key('2')
        
        m1_b = synchronizer.get_mutex_for_key('1')
        m2_b = synchronizer.get_mutex_for_key('2')
        
        m1_a.should == m1_b
        m2_a.should == m2_b
      end
      
      it "returns different mutexes for different keys" do
        synchronizer = ThreadsSynchronizer.new
        
        m1 = synchronizer.get_mutex_for_key('1')
        m2 = synchronizer.get_mutex_for_key('2')
        
        m1.should_not == m2
      end
      
    end
  end
end