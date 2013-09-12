require 'spec_helper'


describe Bowling::Frame do
  subject( :instance ){ described_class.new 1, game }


  #= Lets ===

  let( :game                ){ Bowling::Game.new }
  let( :perfect_frame       ){ [ 10,   0     ]   }
  let( :equal_spare         ){ [  5,   5     ]   }
  let( :gutter_frame        ){ [  0,   0     ]   }
  let( :perfect_final_frame ){ [  10, 10, 10 ]   }


  #= Specs ===
  
  it{ should respond_to :frame_number }
  it{ should respond_to :balls        }


  #= Methods ===

  describe '#load' do
    describe 'with perfect frame' do
      before( :each ){ subject.load perfect_frame }

      specify{ 
        subject.load perfect_frame
        subject.balls[0].knocked_pins.should equal 10
        subject.balls[1].knocked_pins.should equal 0
      }
    end
  end


  #= General Specs ===

  describe 'with perfect final frame' do
    subject{ described_class.new 9, game, perfect_final_frame }

    specify{ subject.balls.length.should == 3  }
    specify{ subject.base_score.should   == 10 }
  end


  describe 'basic frame' do
    before( :each ){ subject.load [ 3, 4 ] }

    specify{ subject.base_score.should   equal 7 }
    specify{ subject.strike_score.should equal 0 }
    specify{ subject.spare_score.should  equal 0 }
  end


  describe 'strike frame' do
    before( :each ){ subject.load [ 10 ] }

    specify{ subject.base_score.should equal 10 }
  end


  describe 'perfect before final frame' do
    subject{ described_class.new 8, game, [ 10, 0 ] }
    
    before( :each ){ 
      subject.stub next_frame: described_class.new( 9, game, [ 10, 10, 10 ] ) 
    }

    specify{ subject.base_score.should      equal 10 }
    specify{ subject.strike_score.should    equal 20 }
    specify{ subject.spare_score.should     equal 0  }
    specify{ subject.next_ball.score.should equal 10 }
  end


  describe 'perfect final frame' do
    subject{ described_class.new 9, game, [ 10, 10, 10 ] }

    specify{ subject.base_score.should   equal 10 }
    specify{ subject.strike_score.should equal 20 }
    specify{ subject.spare_score.should  equal 0  }
  end


  describe 'spare final frame' do
    subject{ described_class.new 9, game, [ 0, 10, 10 ] }

    specify{ subject.base_score.should   equal 10 }
    specify{ subject.strike_score.should equal 0  }
    specify{ subject.spare_score.should  equal 10 }
  end

end