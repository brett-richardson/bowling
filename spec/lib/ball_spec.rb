require 'spec_helper'


describe Bowling::Ball do
  
  subject( :instance ){ Bowling::Ball.new 1, frame }


  #= Lets ===

  let( :game  ){ Bowling::Game.new          }
  let( :frame ){ Bowling::Frame.new 1, game }


  #= Specs ===
  
  its( :knocked_pins ){ should equal 0 }

end