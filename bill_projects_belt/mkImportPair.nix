{ pkgslib }: 
{ importInputs, filePath }:
{
  name = baseNameOf (dirOf filePath);
  value = import filePath importInputs;
}
