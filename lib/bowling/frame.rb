class Bowling::Frame

  attr_accessor :balls, :frame_number, :game


  #= Construction ===

  def initialize( frame_number, game, data = nil )
    @frame_number = frame_number
    @game         = game
    @balls        = Array.new( total_balls ){ |i| Bowling::Ball.new i, self }

    load data if data
  end


  #= Public methods ===

  ##
  # Load an array of scores (integers) representing each ball
  #
  def load( data )
    raise ArgumentError.new '#load needs array' unless data.instance_of? Array
    data.each_with_index{ |pins, i| @balls[i].knocked_pins = pins }
  end


  def first_ball
    balls[0]
  end


  def next_frame
    get_frame frame_number+1
  end


  def next_next_frame
    get_frame frame_number+2
  end


  def next_ball
    if final?
      balls[1]
    else
      next_frame.first_ball
    end
  end


  def next_next_ball
    if final?
      next_frame.balls[2]
    elsif next_frame.strike? and not next_frame.final?
      next_next_frame.first_ball
    else
      next_frame.balls[1]
    end
  end


  #= Calculations ===

  def score
    base_score + strike_score + spare_score
  end


  ##
  # The base score ignores the 3rd ball of the final frame
  #
  def base_score
    [ balls[0].score + balls[1].score, 10 ].min # No frame should have more than 10
  end


  ##
  # Strike score represents the _additional_ score added to the base when a strike occurs
  # It is equal to the knocked_pins of the following 2 balls
  #
  def strike_score
    return 0 unless strike?
    
    if final?
      balls[1].score + balls[2].score
    else
      next_ball.score + next_next_ball.score
    end
  end


  ##
  # Spare score represents the _additional_ score added to the base when a spare occurs
  # It is equal to the knocked_pins of the following ball
  #
  def spare_score
    return 0 unless spare?

    if final?
      balls[2].score
    else
      next_ball.score
    end
  end


  def total_balls
    final? ? 3 : 2
  end


  ##
  # Returns true if this is the last frame of the game
  #
  def final?
    frame_number == 9 # Frame with index 9 is 10th frame
  end


  def strike?
    first_ball.perfect?
  end


  def spare?
    not strike? and ( balls[0].score + balls[1].score >= 10 )
  end


  #=============================================================================
    protected
  #=============================================================================


  def get_frame( number )
    if game.frames[number]
      game.frames[number]
    else
      Bowling::NullFrame
    end
  end

end