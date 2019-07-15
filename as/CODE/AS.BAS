DECLARE SUB Entry (x!, FgColor!, Text$)
DECLARE SUB Print.Form ()
DECLARE SUB w8 (delay!)
DECLARE SUB TITLE ()

DEFINT A-Z: CLS
DIM SHARED Gross.Fee!, GST!, Pension!, Dues!, Format$
DIM SHARED Net.Fee!, Agents10!, Agents.GST!, Net.Net!
DIM SHARED file$, TO$, AD$, CODES$

Defaults:
Format$ = "**$##########,.##"
file$ = "re.as"
GS.Tax! = .07
IPA.Pension.Per! = .03: IPA.Dues.Per! = .02
CBC.Pension.Per! = .02: CBC.Dues.Per! = .02

Start:
COLOR 7, 0
ON ERROR GOTO ErrorControl
CALL TITLE
DO
LOCATE 3, 1: COLOR 5, 0: PRINT "Main Menu:";
Entry 5, 9, "Create new form"
Entry 6, 9, "View current form"
Entry 7, 9, "Edit current form"
Entry 8, 9, "Print current form"
Entry 10, 4, "Delete data"
Entry 11, 4, "Kill data file"
Entry 13, 8, "Alter variables"
Entry 14, 8, "Quit"
xx$ = INPUT$(1)
IF UCASE$(xx$) = "Q" THEN END
IF UCASE$(xx$) = "C" THEN GOSUB Create
IF UCASE$(xx$) = "V" THEN GOSUB ViewData
IF UCASE$(xx$) = "E" THEN GOSUB EditData
IF UCASE$(xx$) = "D" THEN GOSUB DeleteData
IF UCASE$(xx$) = "A" THEN GOSUB Setup
IF UCASE$(xx$) = "P" THEN CALL Print.Form
IF UCASE$(xx$) = "K" THEN
 LOCATE 3, 12: COLOR 14, 0
 KILL file$: PRINT "Killing current data file...": w8 (1)
 GOSUB Start
END IF
LOOP

Create:
LOCATE 3, 12: COLOR 14, 0: PRINT "Creating data file..."
w8 (.5): CALL TITLE
LOCATE 3, 1: COLOR 13, 0: PRINT "What is this form "; : COLOR 4, 0: PRINT "REGARDING?";
 LOCATE 4, 80 - LEN(DATE$): COLOR 1, 0: PRINT DATE$
 LOCATE 4, 1: COLOR 1, 0: PRINT "TO: "; : COLOR 7, 0: INPUT "", TO$
 LOCATE 5, 1: COLOR 1, 0: PRINT "Address: "; : COLOR 7, 0: INPUT "", AD$
 LOCATE 6, 1: COLOR 1, 0: PRINT "City/Prov./Zip: "; : COLOR 7, 0: INPUT "", CODES$
LOCATE 3, 31: COLOR 14, 0: PRINT "Press ENTER on a blank line to continue"
COLOR 15, 0: LOCATE 8, 1
OPEN file$ FOR OUTPUT AS #1
DO
 LINE INPUT ""; RE.data$
 IF RE.data$ <> "" THEN PRINT #1, RE.data$
LOOP WHILE RE.data$ <> ""
CLOSE #1
COLOR 13, 0: PRINT "What is the "; : COLOR 4, 0: PRINT "Gross Fee"
COLOR 15, 0: INPUT "$", Gross.Fee!
PRINT
COLOR 13, 0: PRINT "Select "; : COLOR 4, 0: PRINT "ACTRA deduction";
COLOR 13, 0: PRINT " method "; : COLOR 7, 0: PRINT "(";
COLOR 15, 0: PRINT "I"; : COLOR 9, 0: PRINT "PA or "; : COLOR 15, 0: PRINT "C";
COLOR 9, 0: PRINT "BC"; : COLOR 7, 0: PRINT ")"

DO: xxx$ = INPUT$(1)
IF UCASE$(xxx$) = "I" THEN ch = 1: EXIT DO
IF UCASE$(xxx$) = "C" THEN
 ch = 2
 COLOR 13, 0: PRINT "What are the "; : COLOR 4, 0: PRINT "Taxable benefits"
 COLOR 15, 0: INPUT "$", Taxable.Benifits!
 EXIT DO
END IF
LOOP
z = 1
GOSUB Calculate

ViewData:
OPEN file$ FOR INPUT AS #1
CALL TITLE
LOCATE 3, 80 - LEN(DATE$): COLOR 1, 0: PRINT DATE$
LOCATE 3, 1: COLOR 1, 0: PRINT TO$
LOCATE 4, 1: COLOR 1, 0: PRINT AD$
LOCATE 5, 1: COLOR 1, 0: PRINT CODES$
PRINT
DO WHILE NOT EOF(1)
LINE INPUT #1, RE.data$
COLOR 1, 0: PRINT RE.data$
LOOP
CLOSE #1
LOCATE 23, 1: COLOR 14, 0: PRINT "Press {I} to see calculations or {ESC} to return to menu"
DO
 c$ = INPUT$(1)
 IF c$ = CHR$(27) THEN RETURN Start
 IF UCASE$(c$) = "I" THEN EXIT DO
LOOP
CALL TITLE
LOCATE 4, 1
COLOR 2, 0: PRINT "Gross Fee:     ";
COLOR 13, 0: PRINT USING Format$; Gross.Fee!

COLOR 2, 0: PRINT "Gross G.S.T.:  ";
COLOR 13, 0: PRINT USING Format$; GST!

COLOR 2, 0: PRINT "ACTRA deductions"
COLOR 12, 0: PRINT "  Pension:     ";
COLOR 13, 0: PRINT USING Format$; Pension!
COLOR 12, 0: PRINT "  Dues:        ";
COLOR 13, 0: PRINT USING Format$; Dues!

COLOR 2, 0: PRINT "NET Fee:       ";
COLOR 13, 0: PRINT USING Format$; Net.Fee!

COLOR 2, 0: PRINT "Agent's 10%:   ";
COLOR 13, 0: PRINT USING Format$; Agents10!

COLOR 2, 0: PRINT "Agent's G.S.T.:";
COLOR 13, 0: PRINT USING Format$; Agents.GST!

COLOR 2, 0: PRINT "NET Net:       ";
COLOR 13, 0: PRINT USING Format$; Net.Net!

LOCATE 23, 1: COLOR 14, 0: PRINT "Press {C} to see sheet comment or {ESC} to return to menu"
DO
 c$ = INPUT$(1)
 IF c$ = CHR$(27) THEN RETURN Start
 IF UCASE$(c$) = "C" THEN GOSUB ViewData
LOOP

EditData:
CALL TITLE
LOCATE 3, 1: COLOR 14, 0: PRINT "Edit which?"
PRINT
Entry 5, 3, "1 Gross Fee"
Entry 6, 3, "2 Gross G.S.T."
Entry 7, 3, "3 Pension"
Entry 8, 3, "4 Dues"
Entry 9, 3, "5 Net Fee"
Entry 10, 3, "6 Agent's 10%"
Entry 11, 3, "7 Agent's G.S.T."
Entry 12, 3, "8 Net Net"
Entry 13, 3, "9 Taxable Benefits"
Entry 15, 5, "0 Return to Main Menu"
DO
x$ = INPUT$(1)
IF x$ = "0" THEN RETURN Start
LOCATE 17, 1
IF x$ = "1" THEN
 COLOR 13, 0: PRINT "Current Gross Fee is $"; : COLOR 11, 0: PRINT Gross.Fee!
 COLOR 6, 0: INPUT "$", Gross.Fee!
 EXIT DO
END IF
IF x$ = "2" THEN
 COLOR 13, 0: PRINT "Current Gross G.S.T. is $"; : COLOR 11, 0: PRINT GST!
 COLOR 6, 0: INPUT "$", GST!
 EXIT DO
END IF
IF x$ = "3" THEN
 COLOR 13, 0: PRINT "Current Pension is $"; : COLOR 11, 0: PRINT Pension!
 COLOR 6, 0: INPUT "$", Pension!
 GOSUB Mid.Calculate
END IF
IF x$ = "4" THEN
 COLOR 13, 0: PRINT "Current Dues is $"; : COLOR 11, 0: PRINT Dues!
 COLOR 6, 0: INPUT "$", Dues!
 GOSUB Mid.Calculate
END IF
IF x$ = "5" THEN
 COLOR 13, 0: PRINT "Current Net Fee is $"; : COLOR 11, 0: PRINT Net.Fee!
 COLOR 6, 0: INPUT "$", Net.Fee!
 EXIT DO
END IF
IF x$ = "6" THEN
 COLOR 13, 0: PRINT "Current Agent's 10% is $"; : COLOR 11, 0: PRINT Agents10!
 COLOR 6, 0: INPUT "$", Agents10!
 GOSUB After.Altered.10percent:
 EXIT DO
END IF
IF x$ = "7" THEN
 COLOR 13, 0: PRINT "Current Agent's G.S.T. is $"; : COLOR 11, 0: PRINT Agents.GST!
 COLOR 6, 0: INPUT "$", Agents.GST!
 EXIT DO
END IF
IF x$ = "8" THEN
 COLOR 13, 0: PRINT "Current Net Net is $"; : COLOR 11, 0: PRINT Net.Net!
 COLOR 6, 0: INPUT "$", Net.Net!
END IF
IF x$ = "9" THEN
 COLOR 13, 0: PRINT "Current Taxable Benifits are $"; : COLOR 11, 0: PRINT Taxable.Benifits!
 COLOR 6, 0: INPUT "$", Taxable.Benifits!
 EXIT DO
END IF
LOOP
GOSUB Calculate

DeleteData:
Gross.Fee! = 0
GST! = 0
Pension! = 0
Dues! = 0
Net.Fee! = 0
Agents10! = 0
Agents.GST! = 0
Net.Net! = 0
Taxable.Benifits! = 0
LOCATE 3, 12: COLOR 14, 0: PRINT "Deleteing all current data..."
w8 (1)
RETURN Start

Setup:
CALL TITLE
LOCATE 3, 1: COLOR 6, 0: PRINT "Alter which variable?"
Entry 5, 9, "1 GST Percentage"
Entry 6, 9, "2 IPA Pension Percentage"
Entry 7, 9, "3 IPA Dues Percentage"
Entry 8, 9, "4 CBC Pension Percentage"
Entry 9, 9, "5 CBC Dues Percentage"
Entry 11, 5, "0 Return to main menu"
DO
xxx$ = INPUT$(1)
IF xxx$ = "0" THEN RETURN Start
IF xxx$ = "1" THEN
 LOCATE 12, 1: COLOR 12, 0
 PRINT "GST is set at"; : COLOR 4, 0: PRINT GS.Tax!
 COLOR 15, 0: INPUT "", GS.Tax!
  IF GS.Tax! = 0 THEN GOSUB Defaults
 EXIT DO
END IF
IF xxx$ = "2" THEN
 LOCATE 12, 1: COLOR 12, 0
 PRINT "IPA Pension is set at"; : COLOR 4, 0: PRINT IPA.Pension.Per!
 COLOR 15, 0: INPUT "", IPA.Pension.Per!
  IF IPA.Pension.Per! = 0 THEN GOSUB Defaults
 EXIT DO
END IF
IF xxx$ = "3" THEN
 LOCATE 12, 1: COLOR 12, 0
 PRINT "IPA Dues is set at"; : COLOR 4, 0: PRINT IPA.Dues.Per!
 COLOR 15, 0: INPUT "", IPA.Dues.Per!
  IF IPA.Dues.Per! = 0 THEN GOSUB Defaults
 EXIT DO
END IF
IF xxx$ = "4" THEN
 LOCATE 12, 1: COLOR 12, 0
 PRINT "CBC Pension is set at"; : COLOR 4, 0: PRINT CBC.Pension.Per!
 COLOR 15, 0: INPUT "", CBC.Pension.Per!
  IF CBC.Pension.Per! = 0 THEN GOSUB Defaults
 EXIT DO
END IF
IF xxx$ = "5" THEN
 LOCATE 12, 1: COLOR 12, 0
 PRINT "CBC Dues is set at"; : COLOR 4, 0: PRINT CBC.Dues.Per!
 COLOR 15, 0: INPUT "", CBC.Dues.Per!
  IF CBC.Dues.Per! = 0 THEN GOSUB Defaults
 EXIT DO
END IF
LOOP

Calculate:
IF ch = 1 THEN
 Pension.Per! = IPA.Pension.Per!
 Dues.Per! = IPA.Dues.Per!
ELSEIF ch = 2 THEN
 Pension.Per! = CBC.Pension.Per!
 Dues.Per! = CBC.Dues.Per!
END IF
GST! = (Gross.Fee! + Taxable.Benifits!) * GS.Tax!
Pension! = Gross.Fee! * Pension.Per!
Dues! = Gross.Fee! * Dues.Per!
Mid.Calculate:
Net.Fee! = Gross.Fee! + GST! - (Pension! + Dues!)
Agents10! = Gross.Fee! * .1
After.Altered.10percent:
Agents.GST! = Agents10! * GS.Tax!
Net.Net! = Net.Fee! - Agents10! - Agents.GST!

IF z = 1 THEN z = 0: GOSUB ViewData
RETURN Start

ErrorControl:
IF ERR = 53 THEN
 LOCATE 3, 12: COLOR 14, 0
 PRINT "Data file doesn't exist!"
END IF
w8 (1)
RESUME Start

DEFSNG A-Z
SUB Entry (x, FgColor, Text$) STATIC
LOCATE x, 1: COLOR 7, 0: PRINT CHR$(40): LOCATE x, 3: PRINT CHR$(41)
LOCATE x, 2: COLOR 15, 0: PRINT LEFT$(Text$, 1)
LOCATE x, 4: COLOR FgColor, 0: PRINT MID$(Text$, 2)
END SUB

DEFINT A-Z
SUB Print.Form

LOCATE 3, 12: COLOR 14, 0: PRINT "Printing current form...": w8 (1)
LOCATE 3, 12: COLOR 0, 0: PRINT SPACE$(24)

OPEN file$ FOR INPUT AS #1
LPRINT
LPRINT
LPRINT
LPRINT "GST No.133093633                Accounting Sheet                   "; DATE$
LPRINT "----------------                ----------------                   ----------"
LPRINT
LPRINT TO$
LPRINT AD$
LPRINT CODES$
LPRINT
DO WHILE NOT EOF(1)
 LINE INPUT #1, RE.data$
 LPRINT RE.data$
LOOP
CLOSE #1
LPRINT
LPRINT
LPRINT "GROSS FEE"
LPRINT "---------"
LPRINT USING Format$; Gross.Fee!
LPRINT
LPRINT "GST"
LPRINT USING Format$; GST!
LPRINT
LPRINT "ACTRA deductions"
LPRINT "----------------"
LPRINT "Pension"
LPRINT USING Format$; Pension!
LPRINT "Dues"
LPRINT USING Format$; Dues!
LPRINT
LPRINT
LPRINT
LPRINT "NET FEE"
LPRINT "-------"
LPRINT USING Format$; Net.Fee!
LPRINT
LPRINT "Agent's 10%"
LPRINT USING Format$; Agents10!
LPRINT
LPRINT "GST"
LPRINT USING Format$; Agents.GST!
LPRINT
LPRINT "NET NET"
LPRINT "-------"
LPRINT USING Format$; Net.Net!
LPRINT
LPRINT
LPRINT USING "Enclosed is a cheque in the amount of **$##########,.##"; Net.Net!
OPEN "LPT1:BIN" FOR OUTPUT AS #2
PRINT #2, CHR$(12); CHR$(27); "E";  'Eject page, reset
CLOSE #2
END SUB

SUB TITLE
CLS : SCREEN 0
COLOR 11, 0: LOCATE 1, 1: PRINT "Accounting Sheet Generator";
COLOR 10, 0: PRINT " v1.045"
COLOR 12, 0: LOCATE 1, 55: PRINT "by Alex Bevilacqua (c)1996"
COLOR 8, 0: LOCATE 2, 1: PRINT STRING$(80, "-")
END SUB

SUB w8 (delay!)
x! = TIMER
WHILE TIMER < x! + delay!: WEND
END SUB

