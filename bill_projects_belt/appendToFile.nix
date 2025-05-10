{ pathToFile, textToAppend }:
with builtins;
let
  existingContent = 
    if pathExists pathToFile then 
      readFile pathToFile
    else 
     "";
  newContent = existingContent + textToAppend;
in builtins.writeFile pathToFile newContent
