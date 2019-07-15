DECLARE SUB paws (delay!)
DEFINT A-Z

VeryStart:
ComPort$ = "3": Irq$ = "7": Speed$ = "14400": Address$ = "0x3e8"
GameType$ = "2": Difficulty$ = "4": Monsters$ = "2"
Warp$ = "01": DoomDir$ = "c:\games\doom2"

Start:
CLS
LOCATE 1, 1: COLOR 11, 0: PRINT "DOOM ][ ModemManager"
LOCATE 1, 27: COLOR 12, 0: PRINT "(c)1996 by Alex Bevilacqua"
LOCATE 1, 61: COLOR 11, 0: PRINT "press {ESC} to quit"
LOCATE 2, 1: COLOR 7, 0: PRINT STRING$(80, "-")
LOCATE 3, 1: COLOR 9, 0: PRINT "COM"; : COLOR 14, 0: PRINT USING "[&]"; ComPort$
LOCATE 3, 8: COLOR 9, 0: PRINT "IRQ"; : COLOR 14, 0: PRINT USING "[&]"; Irq$
LOCATE 3, 15: COLOR 9, 0: PRINT "MODEM"; : COLOR 14, 0: PRINT USING "[&]"; Speed$
LOCATE 3, 28: COLOR 9, 0: PRINT "ADDRESS"; : COLOR 14, 0: PRINT USING "[&]"; Address$
 SELECT CASE GameType$
  CASE "1": GInfo$ = "Cooperative"
  CASE "2": GInfo$ = "DeathMatch "
 END SELECT
LOCATE 3, 43: COLOR 9, 0: PRINT "GAME"; : COLOR 14, 0: PRINT USING "[&]"; GInfo$
 SELECT CASE Monsters$
  CASE "1": MInfo$ = "ON     "
  CASE "2": MInfo$ = "OFF    "
  CASE "3": MInfo$ = "Respawn"
 END SELECT
LOCATE 3, 61: COLOR 9, 0: PRINT "MONSTERS"; : COLOR 14, 0: PRINT USING "[&]"; MInfo$
LOCATE 4, 1: COLOR 9, 0: PRINT "WARP"; : COLOR 14, 0: PRINT USING "[&]"; Warp$
 SELECT CASE Difficulty$
  CASE "1": DInfo$ = "I'm too young to die"
  CASE "2": DInfo$ = "Hey, not too rough  "
  CASE "3": DInfo$ = "Hurt me plenty      "
  CASE "4": DInfo$ = "Ultra-Violence!     "
  CASE "5": DInfo$ = "NIGHTMARE           "
 END SELECT
LOCATE 4, 10: COLOR 9, 0: PRINT "DIFFICULTY"; : COLOR 14, 0: PRINT USING "[&]"; DInfo$
LOCATE 4, 43: COLOR 9, 0: PRINT "DOOM DIRECTORY"; : COLOR 14, 0: PRINT USING "[&]"; DoomDir$
LOCATE 5, 1: COLOR 7, 0: PRINT STRING$(80, "-")
LOCATE 6, 3: COLOR 4, 0: PRINT " ommunication Settings"
LOCATE 6, 2: COLOR 15, 0: PRINT "C"
LOCATE 6, 1: COLOR 7, 0: PRINT "(": LOCATE 6, 3: PRINT ")"
LOCATE 7, 3: COLOR 4, 0: PRINT " ame Settings"
LOCATE 7, 2: COLOR 15, 0: PRINT "G"
LOCATE 7, 1: COLOR 7, 0: PRINT "(": LOCATE 7, 3: PRINT ")"
LOCATE 8, 3: COLOR 4, 0: PRINT " ession Settings"
LOCATE 8, 2: COLOR 15, 0: PRINT "S"
LOCATE 8, 1: COLOR 7, 0: PRINT "(": LOCATE 8, 3: PRINT ")"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
IF UCASE$(enter$) = "C" THEN GOSUB CommSet
IF UCASE$(enter$) = "G" THEN GOSUB GameSet
IF UCASE$(enter$) = "S" THEN GOSUB SessionSet
LOOP
END

CommSet:
LOCATE 10, 3: COLOR 2, 0: PRINT " om Port"
LOCATE 10, 2: COLOR 15, 0: PRINT "C"
LOCATE 10, 1: COLOR 7, 0: PRINT "(": LOCATE 10, 3: PRINT ")"
LOCATE 11, 3: COLOR 2, 0: PRINT " rq"
LOCATE 11, 2: COLOR 15, 0: PRINT "I"
LOCATE 11, 1: COLOR 7, 0: PRINT "(": LOCATE 11, 3: PRINT ")"
LOCATE 12, 3: COLOR 2, 0: PRINT " odem Speed"
LOCATE 12, 2: COLOR 15, 0: PRINT "M"
LOCATE 12, 1: COLOR 7, 0: PRINT "(": LOCATE 12, 3: PRINT ")"
LOCATE 13, 3: COLOR 2, 0: PRINT " ort Address"
LOCATE 13, 2: COLOR 15, 0: PRINT "P"
LOCATE 13, 1: COLOR 7, 0: PRINT "(": LOCATE 13, 3: PRINT ")"

DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
IF UCASE$(enter$) = "C" THEN GOSUB ComPort
IF UCASE$(enter$) = "I" THEN GOSUB Irq
IF UCASE$(enter$) = "M" THEN GOSUB ModemSpeed
IF UCASE$(enter$) = "P" THEN GOSUB Address
LOOP: GOSUB Start

GameSet:
LOCATE 10, 3: COLOR 2, 0: PRINT " ame Type"
LOCATE 10, 2: COLOR 15, 0: PRINT "G"
LOCATE 10, 1: COLOR 7, 0: PRINT "(": LOCATE 10, 3: PRINT ")"
LOCATE 11, 3: COLOR 2, 0: PRINT " ifficulty"
LOCATE 11, 2: COLOR 15, 0: PRINT "D"
LOCATE 11, 1: COLOR 7, 0: PRINT "(": LOCATE 11, 3: PRINT ")"
LOCATE 12, 3: COLOR 2, 0: PRINT " onster Setting"
LOCATE 12, 2: COLOR 15, 0: PRINT "M"
LOCATE 12, 1: COLOR 7, 0: PRINT "(": LOCATE 12, 3: PRINT ")"
LOCATE 13, 3: COLOR 2, 0: PRINT " tarting Level"
LOCATE 13, 2: COLOR 15, 0: PRINT "S"
LOCATE 13, 1: COLOR 7, 0: PRINT "(": LOCATE 13, 3: PRINT ")"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
IF UCASE$(enter$) = "G" THEN GOSUB GameType
IF UCASE$(enter$) = "D" THEN GOSUB Difficulty
IF UCASE$(enter$) = "M" THEN GOSUB MonsterSet
IF UCASE$(enter$) = "S" THEN GOSUB StartingLv
LOOP: GOSUB Start

SessionSet:
LOCATE 10, 3: COLOR 2, 0: PRINT " onnection Method"
LOCATE 10, 2: COLOR 15, 0: PRINT "C"
LOCATE 10, 1: COLOR 7, 0: PRINT "(": LOCATE 10, 3: PRINT ")"
LOCATE 11, 3: COLOR 2, 0: PRINT " oom Directory"
LOCATE 11, 2: COLOR 15, 0: PRINT "D"
LOCATE 11, 1: COLOR 7, 0: PRINT "(": LOCATE 11, 3: PRINT ")"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
IF UCASE$(enter$) = "C" THEN GOSUB ConnectMethod
IF UCASE$(enter$) = "D" THEN GOSUB DoomDir
LOOP: GOSUB Start

ComPort:
LOCATE 16, 1: COLOR 5, 0: PRINT "Com Port >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1 - 4"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
SELECT CASE enter$
 CASE "1" TO "4"
 ComPort$ = enter$
 GOSUB Start
 CASE ELSE
END SELECT
LOOP
GOSUB Start

Irq:
LOCATE 16, 1: COLOR 5, 0: PRINT "Irq >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1 - 9"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
SELECT CASE enter$
 CASE "1" TO "9"
 Irq$ = enter$
 GOSUB Start
 CASE ELSE
END SELECT
LOOP
GOSUB Start

ModemSpeed:
LOCATE 16, 1: COLOR 5, 0: PRINT "Modem Speed >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1-9600, 2-14400, 3-38400, 4-57600"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
SELECT CASE enter$
 CASE "1"
 Speed$ = "9600 "
 GOSUB Start
 CASE "2"
 Speed$ = "14400"
 GOSUB Start
 CASE "3"
 Speed$ = "38400"
 GOSUB Start
 CASE "4"
 Speed$ = "57600"
 GOSUB Start
 CASE ELSE
END SELECT
LOOP
GOSUB Start
Address:
LOCATE 16, 1: COLOR 5, 0: PRINT "COM Port Address >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1-0x2e0, 2-0x2e8, 3-0x2f8, 4-0x3e8, 5-0x3f8"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
SELECT CASE enter$
 CASE "1"
 Address$ = "0x2e0"
 GOSUB Start
 CASE "2"
 Address$ = "0x2e8"
 GOSUB Start
 CASE "3"
 Address$ = "0x2f8"
 GOSUB Start
 CASE "4"
 Address$ = "0x3e8"
 GOSUB Start
 CASE "5"
 Address$ = "0x3f8"
 GOSUB Start
CASE ELSE
END SELECT
LOOP
GOSUB Start

GameType:
LOCATE 16, 1: COLOR 5, 0: PRINT "Method of Play >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1-Cooperative, 2-DeathMatch"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
SELECT CASE enter$
 CASE "1"
 GameType$ = enter$
 GOSUB Start
 CASE "2"
 GameType$ = enter$
 GOSUB Start
 CASE ELSE
END SELECT
LOOP: GOSUB Start

Difficulty:
LOCATE 16, 1: COLOR 5, 0: PRINT "Difficulty >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1-I'm too young to die, 2-Hey, not too rough, 3-Hurt me plenty"
LOCATE 18, 1: COLOR 11, 0: PRINT "4-Ultra-Violence!, 5-NIGHTMARE"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
SELECT CASE enter$
 CASE "1"
 Difficulty$ = enter$
 GOSUB Start
 CASE "2"
 Difficulty$ = enter$
 GOSUB Start
 CASE "3"
 Difficulty$ = enter$
 GOSUB Start
 CASE "4"
 Difficulty$ = enter$
 GOSUB Start
 CASE "5"
 Difficulty$ = enter$
 GOSUB Start
CASE ELSE
END SELECT
LOOP
GOSUB Start

MonsterSet:
LOCATE 16, 1: COLOR 5, 0: PRINT "Monster Settings >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1-Monsters, 2-No Monsters, 3-Monsters Respawn"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
SELECT CASE enter$
CASE "1"
Monsters$ = enter$
GOSUB Start
CASE "2"
Monsters$ = enter$
GOSUB Start
CASE "3"
Monsters$ = enter$
GOSUB Start
CASE ELSE
END SELECT
LOOP: GOSUB Start

StartingLv:
LOCATE 16, 1: COLOR 5, 0: PRINT "Starting Level >"
LOCATE 17, 1: COLOR 11, 0: PRINT "1 - 30"
LOCATE 16, 18: COLOR 1, 0: INPUT "", Warp$
SELECT CASE Warp$
CASE "01" TO "30"
CASE ELSE
Warp$ = "01"
END SELECT
GOSUB Start

DoomDir:
LOCATE 17, 1: COLOR 5, 0: INPUT "New Doom 2 Directory > ", DoomDir$
IF DoomDir$ = "" THEN DoomDir$ = "c:\games\doom2"
GOSUB Start

ConnectMethod:
LOCATE 17, 3: COLOR 5, 0: PRINT " ialing or    eceiving"
LOCATE 17, 2: COLOR 15, 0: PRINT "D"
LOCATE 17, 1: COLOR 7, 0: PRINT "(": LOCATE 17, 3: PRINT ")"
LOCATE 17, 14: COLOR 7, 0: PRINT "(": LOCATE 17, 16: PRINT ")"
LOCATE 17, 15: COLOR 15, 0: PRINT "R"
DO
enter$ = INPUT$(1)
IF enter$ = CHR$(27) THEN EXIT DO
IF UCASE$(enter$) = "D" THEN GOSUB Dial
IF UCASE$(enter$) = "R" THEN GOSUB Answer
LOOP: GOSUB Start

Dial:
LOCATE 19: COLOR 9, 0: PRINT "Dial > "
LOCATE 19, 8: COLOR 13, 0: INPUT "", Number$
LOCATE 21: COLOR 19, 0: PRINT "Dialing ..."
paws (1)
GOSUB DoIt

Answer:
LOCATE 19: COLOR 19, 0: PRINT "Awaiting Call ..."
Number$ = " -ANSWER"
paws (1)
GOSUB DoIt:

DoIt:
IF GameType$ = "1" THEN TypeofPlay$ = ""
IF GameType$ = "2" THEN TypeofPlay$ = " -DEATHMATCH"
IF Monsters$ = "1" THEN MMonsters$ = ""
IF Monsters$ = "2" THEN MMonsters$ = " -NOMONSTERS"
IF Monsters$ = "3" THEN MMonsters$ = " -RESPAWN"
IF Warp$ = "" THEN Warp$ = "01"
IF DoomDir$ = "" THEN DoomDir$ = "c:\games\doom2"
Exe$ = "SERSETUP"
ComPort$ = " -COM " + ComPort$
Irq$ = " -IRQ " + Irq$
Address$ = " -PORT " + Address$
Speed$ = " -" + Speed$
SkillLv$ = " -SKILL " + Difficulty$
Warp$ = " -WARP " + Warp$
IF Number$ <> " -ANSWER" THEN Number$ = " -DIAL " + Number$
CHDIR "\": CHDIR DoomDir$
SHELL "cls"
SHELL Exe$ + ComPort$ + Irq$ + Address$ + Speed$ + SkillLv$ + TypeofPlay$ + MMonsters$ + Warp$ + Number$
COLOR 7, 0
CHDIR ".."
paws (1)
GOSUB VeryStart

SUB paws (delay!)
x! = TIMER
WHILE TIMER < x! + delay!: WEND
END SUB

