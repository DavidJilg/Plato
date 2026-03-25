(define (domain blocksworld)
(:requirements :negative-preconditions :typing)
(:types 
  Boolean - ROOT
  block - ROOT
  root - OBJECT
)
(:predicates 
  (Holding ?block1 - BLOCK)
  (On ?block1 - BLOCK ?block2 - BLOCK)
  (OnGround ?block1 - BLOCK)
  (TopClear ?block1 - BLOCK)
)
(:action pick-up-from-block
:parameters (?block1 - BLOCK ?block2 - BLOCK)
:precondition 
  (and (On ?block1 ?block2)
  (TopClear ?block1)
   (forall (?block3 - BLOCK)
      (not (Holding ?block3))))
:effect 
  (and (Holding ?block1)
  (TopClear ?block2)
  (not (On ?block1 ?block2)))
)
(:action pick-up-from-ground
:parameters (?block1 - BLOCK)
:precondition 
  (and (OnGround ?block1)
  (TopClear ?block1)
   (forall (?block2 - BLOCK)
      (not (Holding ?block2))))
:effect 
  (and (Holding ?block1)
  (not (OnGround ?block1)))
)
(:action put-down-on-block
:parameters (?block1 - BLOCK ?block2 - BLOCK)
:precondition 
  (and (Holding ?block1)
  (TopClear ?block2))
:effect 
  (and (On ?block1 ?block2)
  (not (TopClear ?block2))
  (not (Holding ?block1)))
)
(:action put-down-on-ground
:parameters (?block1 - BLOCK)
:precondition 
  (and (Holding ?block1))
:effect 
  (and (OnGround ?block1)
  (not (Holding ?block1)))
)
)