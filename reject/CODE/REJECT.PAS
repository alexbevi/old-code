{$r+}
program REJECT;

uses CRT, DOS, PRINTER, Lib;

var wn, wa1, wa2, cipr, copc: String;
    F: Text;
    MaxItems: Integer;
    Item: array[1..10] of String;
{-----------------------------------------------------------------------------}
Procedure Header;
var a: Integer;
begin
  CLS(0);
  gotoXY(1,1);
  TextColor(5);
  write('Rejection Sheet Generator');
  TextColor(11);
  writeln('(C)1996 Alex Bevilacqua':54);
  TextColor(8);
  Rep('Н',80);
end;
{-----------------------------------------------------------------------------}
Procedure Main;
begin
  CursorOff;
  CLS(0);
  Header;
  Entry(1,3,10,0,'Create a new worksheet');
  Entry(1,4,10,0,'View current worksheet');
  Entry(1,5,10,0,'Print current worksheet');
  Entry(1,10,9,0,'Quit');
end;
{-----------------------------------------------------------------------------}
Procedure CREATE;
var a: Integer;
    y, m, d, dow: Word;
    Ch: Char;
const
    days: array[0..6] of String = ('Sunday','Monday','Tuesday','Wednesday',
                                   'Thursday','Friday','Saturday');
    months: array[1..12] of String = ('January','February','March',
                                      'April','May','June','July','August',
                                      'September','October','November','December');
begin
  Header;
  TextColor(9);
  write('Date: ');
    GetDate(y, m, d, dow);
    TextColor(3);
    writeln(days[dow],',',' ', months[m],' ', d:1,', ', y:1);
   CursorON;
   TextColor(9);
    write('Writer''s Name: ');
    TextColor(3);
    readln(wn);
  TextColor(9);
    write('Writer''s Address (Line 1): ');
    TextColor(3);
    readln(wa1);
  TextColor(9);
    write('Writer''s Address (Line 2): ');
    TextColor(3);
    readln(wa2);
  TextColor(9);
    write('City, Province: ');
    TextColor(3);
    readln(cipr);
  TextColor(9);
    write('Country, Postal Code: ');
    TextColor(3);
    readln(copc);
   writeln;
   writeln;
   TextColor(10);
     write('How many items: ');
     TextColor(3);
     readln(MaxItems);
   for a:= 1 to 10 do
     begin
       Item[a]:= '';
     end;
   for a:= 1 to MaxItems do
     begin
       TextColor(1);
       write('Data for Item #',a,': ');
       TextColor(11);
       readln(Item[a]);
     end;
    Rewrite(F);
    writeln(F, days[dow],',',' ', months[m],' ', d:1,', ', y:1);
    writeln(F);
    writeln(F, wn);
    writeln(F, wa1);
      if length(wa2) > 0 then writeln(F, wa2);
    writeln(F, cipr);
    writeln(F, copc);
    writeln(F);
    writeln(F, 'Dear ',wn,':');
    writeln(F);
    write(F, '     Thank you very much for your ');
    for a:= 1 to MaxItems do
     begin
       if MaxItems - a >= 2 then write(F, Item[a],', ');
       if MaxItems - a = 1 then write(F, Item[a], ' and ');
       if MaxItems - a = 0 then writeln(F, Item[a], '.');
     end;
    writeln(F, 'I am afraid that I cannot take you on as my roster is full and');
    writeln(F, 'I am not accepting any new clients.');
    writeln(F, 'I wish you the best and thank you for thinking of my agency.');
    writeln(F);
    writeln(F, 'Yours sincerely, ');
    writeln(F);
    writeln(F);
    writeln(F);
    writeln(F, 'Krisztina Bevilacqua');
    writeln(F, 'KB/ab');
  close(F);
  gotoXY(1,25);
  TextColor(14);
  CursorOFF;
  write('press ENTER to continue...');
    repeat
    Ch:= ReadKey;
    until (Keypressed) or (Ch = #13);
    Main;
end;
{-----------------------------------------------------------------------------}
Procedure VIEW;
var Ch: Char;
begin
  Header;
  reset(F);
  while not eof(F) do
    begin
      TextColor(6);
      read(F, Ch);
      write(Ch);
    end;
  close(F);
  gotoXY(1,25);
  TextColor(14);
  write('press ENTER to continue...');
    repeat
    Ch:= ReadKey;
    until (Keypressed) or (Ch = #13);
  Main;
end;
{-----------------------------------------------------------------------------}
Procedure PRINT;
var Ch: Char;
begin
writeln(LST);
writeln(LST);
writeln(LST);
writeln(LST);
writeln(LST);
writeln(LST);
writeln(LST);
writeln(LST);
writeln(LST);
writeln(LST);
reset(F);
while not eof(F) do
  begin
    read(F, Ch);
    write(LST, Ch);
  end;
write(LST, #12, #27, 'E');
end;
{-----------------------------------------------------------------------------}
Procedure Run;
var Ch: Char;
begin
  Main;
  repeat
    Ch:= Readkey;
    if upcase(Ch) = 'C' then CREATE;
    if upcase(Ch) = 'V' then VIEW;
    if upcase(Ch) = 'P' then PRINT;
  until upcase(Ch) = 'Q';
end;
{-----------------------------------------------------------------------------}
begin
  Assign(F, 'reject.аб');
  Run;
end.