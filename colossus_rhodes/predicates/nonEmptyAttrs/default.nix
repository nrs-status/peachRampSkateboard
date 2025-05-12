{ ... }:
with builtins; {
  predName = "nonEmptyAttrs";
  func = x: 0 < length (attrNames x);
}
