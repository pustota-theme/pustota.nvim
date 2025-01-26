;; extends

[
 "&"
 "*"
 "|"
 ">"
 ] @operator

(flow_node (plain_scalar (string_scalar) @operator) (#eq? @operator "<<"))

