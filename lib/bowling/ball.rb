class Bowling::Ball

  attr_accessor :ball_position, :knocked_pins, :frame
  alias_method  :score, :knocked_pins


  #= Construction ===

  def initialize( ball_position, frame, knocked_pins = nil )
    @ball_position = ball_position
    @frame         = frame
    @knocked_pins  = knocked_pins || 0
  end


  #= Public methods ===

  def knock_over( amount )
    knocked_pins += amount
    raise Error.new 'Knocked pins can not exceed 10' if knocked_pins > 10
  end


  def next_ball
    if strike?
      frame.next_frame.first_ball
    else
      frame.balls[ball_position + 1]
    end
  end


  #= Calculations ===

  def strike?
    first_ball? and perfect?
  end


  def perfect?
    knocked_pins == 10
  end
  

  def first_ball?
    ball_position == 0 
  end

end