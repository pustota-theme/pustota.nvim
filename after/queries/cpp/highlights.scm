;; extends

((union_specifier name: (type_identifier) @type.definition))
((enum_specifier name: (type_identifier) @type.definition))
((struct_specifier name: (type_identifier) @type.definition))
((class_specifier name: (type_identifier) @type.definition))

((assignment_expression left: (field_expression (".") @operator.dot)))
