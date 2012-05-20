$:.unshift '.';require File.dirname(__FILE__) + '/test_helper'

class NthrecordTest < Test::Unit::TestCase
  
  context "nothing in table" do
    setup do
      Player.delete_all("id > -1")
    end
    
    should "show an empty array" do
      assert_equal 0, Player.count
      assert_equal nil, Player.nthrecord
      assert_equal [], Player.nthrecord(1)
    end
    
  end

   context "make 4 records" do
      setup do
        @a = FactoryGirl.create(:player, :name => "andy")
        @b = FactoryGirl.create(:player, :name => "bart")
        @c = FactoryGirl.create(:player, :name => "chad")
        @d = FactoryGirl.create(:player, :name => "dave")
        @players = Player.all
      end
      
       should "get every record" do
        assert_equal @players, Player.nthrecord(1)
       end

       should "get every 2rd record by order id DESC" do
        assert_equal [@players[3], @players[1]], Player.nthrecord(2).order("id DESC")
       
      end

      
    end
end
