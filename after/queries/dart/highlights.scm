;; extends

((enum_declaration name: (identifier) @type.definition))
((class_definition name: (identifier) @type.definition))
((mixin_declaration (identifier) @type.definition))

((annotation ("@") @operator.decorator))
