class Bowling::Game

  attr_accessor :frames


  def initialize( data = nil )
    @frames = Array.new( 10 ){ |i| Bowling::Frame.new i, self }
    load data if data
  end


  def load( data )
    raise ArgumentError.new '#load needs array' unless data.instance_of? Array
    data.each_with_index{ |frame, i| @frames[i].load frame }
  end


  def score
    frames.inject( 0 ){ |total, frame| total + frame.score }
  end

end
