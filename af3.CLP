
(deftemplate father-of (slot father) (slot child))
(deftemplate mother-of (slot mother) (slot child))
(deftemplate parent-of (slot parent) (slot child))
(deftemplate grandchild-of (slot gparent) (slot child))
(deftemplate uncle-of (slot uncle) (slot child))
(deftemplate aunt-of (slot aunt) (slot child))
(deftemplate greatgrandparent-of (slot child) (slot ggparent))

(deffacts male-feamle
    (female "Diana")
    (female "Anne")
    (female "Sarah")
    (female "Mum")
    (female "Kydd")
    (female "Elizabeth")
    (female "Margaret")
    (female "Zara")
    (female "Beatrice")
    (female "Eugenie")

    (male "George")
    (male "Spencer")
    (male "Philip")
    (male "Charles")
    (male "Mark")
    (male "Andrew")
    (male "Edward")
    (male "William")
    (male "Harry")
    (male "Peter")
)

(deffacts heritage

   (mother-of (mother "Mum") (child "Elizabeth"))
   (mother-of (mother "Mum") (child "Margaret"))

   (mother-of (mother "Kydd") (child "Diana"))


   (mother-of (mother "Elizabeth") (child "Charles"))
   (mother-of (mother "Elizabeth") (child "Anne"))
   (mother-of (mother "Elizabeth") (child "Andrew"))
   (mother-of (mother "Elizabeth") (child "Edward"))

   (mother-of (mother "Diana") (child "William"))
   (mother-of (mother "Diana") (child "Harry"))


   (mother-of (mother "Anne") (child "Peter"))
   (mother-of (mother "Anne") (child "Zara"))

   (mother-of (mother "Sarah") (child "Eugenie"))
   (mother-of (mother "Sarah") (child "Beatrice"))
   
   (father-of (father "George") (child "Elizabeth"))
   (father-of (father "George") (child "Margaret"))

   (father-of (father "Spencer") (child "Diana"))

   (father-of (father "Philip") (child "Charles"))
   (father-of (father "Philip") (child "Anne"))
   (father-of (father "Philip") (child "Andrew"))
   (father-of (father "Philip") (child "Edward"))

   (father-of (father "Charles") (child "William"))
   (father-of (father "Charles") (child "Harry"))

   (father-of (father "Mark") (child "Peter"))
   (father-of (father "Mark") (child "Zara"))

   (father-of (father "Andrew") (child "Eugenie"))
   (father-of (father "Andrew") (child "Beatrice")))

(defrule parent-of ""
    (or 
          (mother-of (mother ?parent) (child ?child)) 
          (father-of (father ?parent) (child ?child)))
    =>
    (assert (parent-of (parent ?parent) (child ?child)))) 

(defrule sibling-of "" 
  (and 
        (father-of (father ?father) (child ?c2))
        (father-of (father ?father) (child ?c1))


        )

  =>
  (assert (sibling-of ?c1 ?c2))

)

(defrule detet-fact-sib ?f <-(sibling-of ?child1 ?child1)
=> (retract ?f))


(defrule brother-of "" 
  
        (sibling-of ?me ?brother)
        (male ?brother)
        

  =>
  (assert (brother-of ?me ?brother))

)

(defrule sister-of "" 
  
        (sibling-of ?me ?sister)
        (female ?sister)
  

  =>
  (assert (sister-of ?me ?sister))
  )

(defrule grandchild-of "" 
  (and 
        (parent-of (parent ?parent) (child ?child))
        (parent-of (parent ?gparent) (child ?parent))
  )
  
  =>
  (assert (grandchild-of (gparent ?gparent) (child ?child)))
  )



(defrule uncle-of "" 
  (and 
        (parent-of (parent ?parent) (child ?child))
        (brother-of ?parent ?uncle )
  )
  
  =>
  (assert (uncle-of (uncle ?uncle) (child ?child)))
  )


(defrule aunt-of "" 
  (and 
        (parent-of (parent ?parent) (child ?child))
        (sister-of ?parent ?aunt )
  )
  
  =>
  (assert (aunt-of (aunt ?aunt) (child ?child)))
  )



(defrule greatgrandparent-of ""
    (and
        (parent-of (parent ?ggparent) (child ?gparent))
        (parent-of (parent ?gparent) (child ?parent)) 
        (parent-of (parent ?parent) (child ?child)) 
    )
    => (assert (greatgrandparent-of (child ?child) (ggparent ?ggparent)))
)


(defrule weded-to "" 
  (and 
        (father-of (father ?father) (child ?child))
        (mother-of (mother ?mother) (child ?child))
        
  )
  
  =>
  (assert (weded-to ?father ?mother))
  )

(defrule brotherinlaw-ofhusband "" 
  (and 
      (weded-to ?husband ?wife)
      (brother-of ?wife ?brother)
        
  )
  
  =>
  (assert (brotherinlaw-ofhusband ?husband ?brother))
  )

(defrule sisterinlaw-ofhusband "" 
  (and 
      (weded-to ?husband ?wife)
      (sister-of ?wife ?sister)
        
  )
  
  =>
  (assert (sisterinlaw-ofhusband ?husband ?sister))
  )



(defrule brotherinlaw-ofwife "" 
  (and 
      (weded-to ?husband ?wife)
      (brother-of ?husband ?brother)
        
  )
  
  =>
  (assert (brotherinlaw-ofwife ?wife ?brother))
  )

(defrule sisterinlaw-ofwife "" 
  (and 
      (weded-to ?husband ?wife)
      (sister-of ?husband ?sister)
        
  )
  
  =>
  (assert (sisterinlaw-ofwife ?wife ?sister))
  )


(defrule firstcousin "" 
  (and 
      
        (parent-of (parent ?parent) (child ?child1))
        (sibling-of ?parent ?sibling)
        (parent-of (parent ?sibling) (child ?child2))

  )
  
  =>
  (assert (firstcousin-of ?child1 ?child2))
  )


  