;; extends

((enum_specifier name: (type_identifier) @type.definition))
((declaration type: (enum_specifier name: (type_identifier) @type)))

((struct_specifier name: (type_identifier) @type.definition))
((declaration type: (struct_specifier name: (type_identifier) @type)))

((union_specifier name: (type_identifier) @type.definition))
((declaration type: (union_specifier name: (type_identifier) @type)))

((field_expression (".") @operator.dot))
; ((number_literal ("f") @operator))
