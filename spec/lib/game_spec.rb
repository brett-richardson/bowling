require 'spec_helper'


describe Bowling::Game do

  #= Lets ===

  let( :perfect_game   ){ Array.new(  9 ){ [ 10     ] } << [ 10, 10, 10 ] }
  let( :spare_game     ){ Array.new(  9 ){ [  0, 10 ] } << [  0, 10,  0 ] }
  let( :all_ones       ){ Array.new(  9 ){ [  1,  1 ] } << [  1,  1     ] }
  let( :all_twos       ){ Array.new(  9 ){ [  2,  2 ] } << [  2,  2     ] }

  let( :geometric_game ){ Array.new( 9 ){ |i| [ i, i ] } << [ 10, 10, 10 ] }


  #= Specs ===

  subject{ described_class.new }

  it{ should respond_to :frames }
  

  describe '#score' do
    context 'with perfect_game data' do
      before( :each ){ subject.load perfect_game }

      its( :score ){ should == 300 }

      specify( 'all frames have a score of 30' ){
        subject.frames.each do |frame|
          frame.score.should equal 30
        end
      }

      describe 'penultimate frame' do
        specify{ subject.frames[8].base_score.should   equal 10 }
        specify{ subject.frames[8].strike_score.should equal 20 }
        specify{ subject.frames[8].spare_score.should  equal  0 }

        specify{ subject.frames[8].next_ball.ball_position.should equal 0 }
        specify{ subject.frames[8].next_next_ball.ball_position.should equal 1 }
      end
    end

    context 'with spare_game data' do
      before( :each ){ subject.load spare_game }

      its( :score ){ should == 100 }

      specify( 'all frames have a score of 30' ){
        subject.frames.each do |frame|
          frame.score.should equal 10
        end
      }

      describe 'ultimate frame' do
        specify{ subject.frames[9].base_score.should   equal 10 }
        specify{ subject.frames[9].strike_score.should equal  0 }
        specify{ subject.frames[9].spare_score.should  equal  0 }
      end
    end

    context 'with all_ones data' do
      before( :each ){ subject.load all_ones }

      its( :score ){ should == 20 }
    end

    context 'with all_twos data' do
      before( :each ){ subject.load all_twos }

      its( :score ){ should == 40 }
    end

    context 'with geometric_game data' do
      before( :each ){ subject.load geometric_game }

      describe '#base_score' do
        specify{ subject.frames[ 0].base_score.should equal  0 }
        specify{ subject.frames[ 1].base_score.should equal  2 }
        specify{ subject.frames[ 2].base_score.should equal  4 }
        specify{ subject.frames[ 3].base_score.should equal  6 }
        specify{ subject.frames[ 4].base_score.should equal  8 }
        specify{ subject.frames[ 5].base_score.should equal 10 }
        specify{ subject.frames[ 6].base_score.should equal 10 }
        specify{ subject.frames[ 7].base_score.should equal 10 }
        specify{ subject.frames[ 8].base_score.should equal 10 }
        specify{ subject.frames[ 9].base_score.should equal 10 }
      end

      describe '#spare_score' do
        specify{ subject.frames[ 0].spare_score.should equal  0 }
        specify{ subject.frames[ 1].spare_score.should equal  0 }
        specify{ subject.frames[ 2].spare_score.should equal  0 }
        specify{ subject.frames[ 3].spare_score.should equal  0 }
        specify{ subject.frames[ 4].spare_score.should equal  0 }
        specify{ subject.frames[ 5].spare_score.should equal  6 }
        specify{ subject.frames[ 6].spare_score.should equal  7 }
        specify{ subject.frames[ 7].spare_score.should equal  8 }
        specify{ subject.frames[ 8].spare_score.should equal 10 }
        specify{ subject.frames[ 9].spare_score.should equal  0 }
      end

      describe '#strike_score' do
        specify{ subject.frames[ 0].strike_score.should equal  0 }
        specify{ subject.frames[ 1].strike_score.should equal  0 }
        specify{ subject.frames[ 2].strike_score.should equal  0 }
        specify{ subject.frames[ 3].strike_score.should equal  0 }
        specify{ subject.frames[ 4].strike_score.should equal  0 }
        specify{ subject.frames[ 5].strike_score.should equal  0 }
        specify{ subject.frames[ 6].strike_score.should equal  0 }
        specify{ subject.frames[ 7].strike_score.should equal  0 }
        specify{ subject.frames[ 8].strike_score.should equal  0 }
        specify{ subject.frames[ 9].strike_score.should equal 20 }
      end
    end
  end

end