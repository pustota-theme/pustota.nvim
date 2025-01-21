;; extends

((record_declaration name: (identifier) @type.definition))
((enum_declaration name: (identifier) @type.definition))
((interface_declaration name: (identifier) @type.definition))
((class_declaration name: (identifier) @type.definition))

((constructor_declaration name: (identifier) @function))

((marker_annotation ("@") @operator.decorator))
((method_reference ("::") @operator.access))
