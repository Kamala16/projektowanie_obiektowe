PROGRAM sortowanieBabelkowe;

TYPE
  list = array[1..100] of Integer;

VAR
  lista: list;
  i, j, temp: Integer;
  n: Integer = 100;
  len: Integer = 100;

PROCEDURE randomList;
BEGIN
  For i:=1 To len Do
  Begin
    lista[i] := Random(n)+1;
    write(lista[i], ' ');
  End;
END;
  
PROCEDURE sort;
BEGIN
  For i:=1 To len - 1 Do
  Begin
    For j:=1 To len - i Do
    Begin
      if lista[j] > lista[j + 1] then begin
         temp := lista[j];
         lista[j] := lista[j + 1];
	     lista[j + 1] := temp;
      end;
    End;
  End;
END;

BEGIN
  randomlist;
  writeln();
  writeln('POSORTOWANE');
  sort;
  For i:=1 To len Do
  Begin
    write(lista[i], ' ');
  End;
  writeln();
END.
