{ pkgslib }:
{ readerFields }:
with builtins;
pkgslib.attrsets.genAttrs (attrNames readerFields) (key: extensionFunc:
  extension: { ${key} = extensionFunc readerFields.${key} extension; }
)
