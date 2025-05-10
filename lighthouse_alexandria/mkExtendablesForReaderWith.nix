{ pkgslib }:
{ readerFields, extensionFunc }:
with builtins;
pkgslib.attrsets.genAttrs (attrNames readerFields) (key:
  extension: { ${key} = extensionFunc readerFields.${key} extension; }
)
