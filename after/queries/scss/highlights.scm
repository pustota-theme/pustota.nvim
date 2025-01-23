;; extends

((class_selector (".") @type.delimiter))

((pseudo_class_selector (":") @type.delimiter))

((pseudo_element_selector ("::") @type.delimiter))

((id_selector) @type.delimiter)

((color_value) @color)

((unit) @unit)

((mixin_statement (name) @function.definition))

((if_clause ("@if") @keyword))
((else_if_clause ("if") @keyword))
((else_if_clause ("@else") @keyword))
