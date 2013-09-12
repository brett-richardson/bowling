class Bowling::NullFrame < NilClass
	class << self

		def strike?    ; false             ; end
		def balls      ; []                ; end
		def first_ball ; Bowling::NullBall ; end
		
	end
end