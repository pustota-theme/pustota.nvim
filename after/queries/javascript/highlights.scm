;; extends

((class_declaration name: (identifier) @type.definition))

((method_definition name: (property_identifier) @constructor.definition)(#eq? @constructor.definition "constructor"))

