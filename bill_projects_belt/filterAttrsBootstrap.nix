pred: set:
with builtins;
removeAttrs set (filter (name: !pred name set.${name}) (attrNames set));
