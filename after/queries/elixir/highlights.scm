;; extends
(
 (call
   target: (identifier) @defmodule (arguments (alias) @module.definition) 
 )
 (#eq? @defmodule "defmodule")
)

(
 (call
   target: (identifier) @defimpl (arguments (alias) @module.definition)
 )
 (#eq? @defimpl "defimpl")
)

(
 (call
   target: (identifier) @defprotocol (arguments (alias) @module.definition) 
 )
 (#eq? @defprotocol "defprotocol")
)

(
 (call
   target: (identifier) @defimpl
   (arguments (keywords (pair key: (keyword) @impl.keyword)))
 )
 (#eq? @defimpl "defimpl")
)

(
 (pair
   key: (keyword) @keyword.do
   )
 (#eq? @keyword.do "do: ")
)

(
 (dot (".") @dot)
 (#set! priority 120)
)

(
 (
  interpolation
 ) @none
)
