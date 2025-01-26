;; extends

(
 (list_lit 
  value: (sym_lit name: (sym_name) @keyword)
  .
  value: (sym_lit name: (sym_name) @function)
  
 )
 (#any-of? @keyword "defmacro" "defmulti" "defmethod")
)

(
 (list_lit 
  value: (sym_lit name: (sym_name) @keyword)
  .
  value: (sym_lit name: (sym_name) @type.definition)
  
 )
 (#any-of? @keyword "defprotocol" "defrecord")
)

(
 (list_lit
  value: (kwd_lit) @keyword
 )
 (#any-of? @keyword ":require" ":import")
)


