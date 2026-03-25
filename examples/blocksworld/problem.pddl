(define (problem blocksworld-problem)
(:domain blocksworld)
(:objects 
  a - BLOCK
  b - BLOCK
  c - BLOCK
)
(:init
  (On c b)
  (OnGround a)
  (OnGround b)
  (TopClear a)
  (TopClear c)
)
(:goal   (and (On a b)
  (On b c)
  (OnGround c)))
)