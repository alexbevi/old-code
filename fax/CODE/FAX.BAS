DECLARE SUB Border ()
DECLARE SUB w8 (delay!)
DEFINT A-Z
CLS
DIM SHARED text$
LET file$ = "comment.fax"

start:
ON ERROR GOTO Errors
Border
LOCATE 4, 1: COLOR 5, 0: PRINT "{MAIN} menu:"
LOCATE 5, 1: COLOR 7, 0: PRINT "("; SPC(1); ")"
LOCATE 5, 2: COLOR 15, 0: PRINT "C"
LOCATE 5, 4: COLOR 6, 0: PRINT "reate a new cover sheet"
LOCATE 6, 1: COLOR 7, 0: PRINT "("; SPC(1); ")"
LOCATE 6, 2: COLOR 15, 0: PRINT "V"
LOCATE 6, 4: COLOR 6, 0: PRINT "iew current data"
LOCATE 7, 1: COLOR 7, 0: PRINT "("; SPC(1); ")"
LOCATE 7, 2: COLOR 15, 0: PRINT "P"
LOCATE 7, 4: COLOR 6, 0: PRINT "rint current cover sheet"
LOCATE 9, 1: COLOR 7, 0: PRINT "("; SPC(1); ")"
LOCATE 9, 2: COLOR 15, 0: PRINT "K"
LOCATE 9, 4: COLOR 4, 0: PRINT "ill data file"
LOCATE 10, 1: COLOR 7, 0: PRINT "("; SPC(1); ")"
LOCATE 10, 2: COLOR 15, 0: PRINT "Q"
LOCATE 10, 4: COLOR 4, 0: PRINT "uit"


DO
 enter$ = INPUT$(1)
 IF UCASE$(enter$) = "Q" THEN END
 IF UCASE$(enter$) = "C" THEN GOSUB Create
 IF UCASE$(enter$) = "V" THEN GOSUB View.Data
 IF UCASE$(enter$) = "K" THEN KILL file$
 IF UCASE$(enter$) = "P" THEN GOSUB Print.Data
LOOP

Create:
Border
LOCATE 4, 1: COLOR 5, 0: PRINT "{CREATE} menu:"
LOCATE 5, 1: COLOR 9, 0: PRINT "TO (company name):";
 COLOR 7, 0: INPUT "", To1$
LOCATE 6, 1: COLOR 9, 0: PRINT "TO (recipiant's name):";
 COLOR 7, 0: INPUT "", To2$
LOCATE 7, 1: COLOR 9, 0: PRINT "FAX No.:";
 COLOR 7, 0: INPUT "", FaxNum$
LOCATE 8, 1: COLOR 9, 0: PRINT "No. of pages:";
 COLOR 7, 0: INPUT "", Pages
LOCATE 10, 1: COLOR 9, 0: PRINT "COMMENT:"; : COLOR 14, 0: PRINT " press {ENTER} on a blank line to continue"
OPEN file$ FOR OUTPUT AS #1
DO
 COLOR 7, 0
 LINE INPUT ""; comment$
 IF comment$ <> "" THEN PRINT #1, comment$
LOOP WHILE comment$ <> ""
CLOSE #1
RETURN start

View.Data:
OPEN file$ FOR INPUT AS #1: CLOSE #1
Border
LOCATE 4, 1: COLOR 5, 0: PRINT "{VIEW} menu:"
LOCATE 6, 1: COLOR 11, 0: PRINT "TO (company name): ----->"; : COLOR 9, 0: PRINT To1$
LOCATE 7, 1: COLOR 11, 0: PRINT "TO (recipiant's name): ->"; : COLOR 9, 0: PRINT To2$
LOCATE 8, 1: COLOR 11, 0: PRINT "FAX No.: --------------->"; : COLOR 9, 0: PRINT FaxNum$
LOCATE 9, 1: COLOR 11, 0: PRINT "No. of pages: ---------->"; : COLOR 9, 0: PRINT Pages
LOCATE 11, 1: COLOR 11, 0: PRINT "COMMENT:"
OPEN file$ FOR INPUT AS #1
DO WHILE NOT EOF(1)
 LINE INPUT #1, comment$
 COLOR 9, 0: PRINT comment$
LOOP
CLOSE #1
LOCATE 4, 15: COLOR 14, 0: PRINT "press any key to continue ..."
WHILE INKEY$ = "": WEND
RETURN start

Print.Data:
LPRINT "KRISZTINA BEVILACQUA"
LPRINT "--------------------"
LPRINT "Writers Representative"
LPRINT "85 Roosevelt Road, Toronto, ON"
LPRINT "M4J 4T8"
LPRINT "-----"
LPRINT "PHONE: (416) 463-7009"
LPRINT "FAX: (416) 463-2206"
LPRINT
LPRINT
LPRINT "FAX TRANSMISSION COVER SHEET"
LPRINT "----------------------------"
LPRINT
LPRINT "DATE: "; DATE$
LPRINT
LPRINT "TO: "; To1$
LPRINT
LPRINT "    "; To2$
LPRINT
LPRINT "FAX TEL #: "; FaxNum$
LPRINT
LPRINT "NUMBER OF PAGES TO FOLLOW: "; Pages
LPRINT
LPRINT "COMMENTS:"
LPRINT
OPEN file$ FOR INPUT AS #1
DO WHILE NOT EOF(1)
 LINE INPUT #1, comment$
 LPRINT comment$
LOOP
CLOSE #1
OPEN "LPT1:BIN" FOR OUTPUT AS #2
PRINT #2, CHR$(12); CHR$(27); "E";  'Eject page, reset
CLOSE #2

Errors:
SELECT CASE ERR
 CASE 53
 LOCATE 4, 15: COLOR 14: PRINT "File doesn't exist..."
 w8 (1)
END SELECT
RESUME start

SUB Border
CLS
LOCATE 1, 1
COLOR 9, 0: PRINT "Fax Transmission Cover Sheet Generator"; : COLOR 12, 0: PRINT "                   (c)1996 Alex Bevilacqua"
COLOR 2, 0: PRINT STRING$(80, "-")
END SUB

SUB w8 (delay!)
x! = TIMER
WHILE TIMER < x! + delay!: WEND
END SUB

