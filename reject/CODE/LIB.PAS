unit Lib;

interface

uses
    CRT, DOS;

procedure Print(color: Integer; Text: String);
procedure Rep(What: String; Times: Integer);
procedure CLS(Bcolor: Integer);
procedure CursorON;
procedure CursorOFF;
procedure Entry(x,y,color: Integer; Text: String);

implementation
(* ------------------------------------------------------------------------ *)
procedure Print(color: Integer; Text: String);
begin
     TextColor(color);
     write(Text);
end;
(* ------------------------------------------------------------------------ *)
procedure Rep(What: String; Times: Integer);
var
   i: Integer;
begin
     for i:= 1 to Times do
         begin
              write(What);
         end;
end;
(* ------------------------------------------------------------------------ *)
procedure CLS(Bcolor: Integer);
begin
     TextBackground(Bcolor);
     ClrScr;
end;
(* ------------------------------------------------------------------------ *)
procedure CursorON;
var
   R: Registers;
begin
  R.AH := $03;
  Intr($10, R);
  R.AH := $01;
  R.CH := R.CH and $1F;
  Intr($10, R);
end;
(* ------------------------------------------------------------------------ *)
procedure CursorOFF;
var
   R: Registers;
begin
  R.AH := $03;
  Intr($10, R);
  R.AH := $01;
  R.CH := R.Ch or $20;
  Intr($10, R);
end;
(* ------------------------------------------------------------------------ *)
procedure Entry(x,y,color: Integer; Text: String);
begin
     gotoXY(x,y);
     Print(7,'(');
     Print(15,copy(Text,1,1));
     Print(7,')');
     Print(color,copy(Text,2,Length(Text)-1));
end;
(* ------------------------------------------------------------------------ *)
END.
