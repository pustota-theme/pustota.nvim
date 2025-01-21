;;extends

((abstract_class_declaration name: (type_identifier) @type.definition))

((class_declaration name: (type_identifier) @type.definition))

((type_alias_declaration name: (type_identifier) @type.definition))

((interface_declaration name: (type_identifier) @type.definition))

((enum_declaration name: (identifier) @type.definition))

((extends_clause value: (identifier) @type.definition))

((function_signature name: (identifier) @function))

((method_definition name: (property_identifier) @constructor.definition)(#eq? @constructor.definition "constructor"))

((decorator ("@") @operator.decorator))
