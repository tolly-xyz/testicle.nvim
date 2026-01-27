(
    ; ensure function mod has attribute #[cfg(test)]
    (attribute_item (
        attribute ((identifier) @mod_attr)
        arguments: (token_tree(identifier)+ @arg)
    ))
    (#eq? @mod_attr "cfg")
    (#any-eq? @arg "test")
    .
    (attribute_item)*
    .
    (mod_item body: (declaration_list 
        (attribute_item ((attribute) @attr))
        (#match? @attr "test")
        .
        (attribute_item)*
        .
        (function_item) @test_fn
    ))
)
