class Bowling::NullBall < NilClass
  class << self

    def score        ; 0     ; end
    def knocked_pins ; 0     ; end
    def strike?      ; false ; end
    def perfect?     ; false ; end

  end
end