DEFINE m_diag BOOLEAN
CONSTANT c_appver = "1.0"

CONSTANT c_f1 = "A simple centered icon with a title below it."
CONSTANT c_f2 = "A title area with a logo, title and date. The text should be centered the image to left and the date to the right"
CONSTANT c_f3 = "An icon and date to the right of the screen and a title to the left."
CONSTANT c_f4 = "Various icons and text tests in a single form."
CONSTANT c_f5 = "Attempt to pad the form so the buttons are at the bottom of the screen."

MAIN

	OPEN FORM f FROM "form"
	DISPLAY FORM f

	DISPLAY c_f1 TO f1
	DISPLAY c_f2 TO f2
	DISPLAY c_f3 TO f3
	DISPLAY c_f4 TO f4
	DISPLAY c_f5 TO f5

	INPUT BY NAME m_diag ATTRIBUTE(UNBUFFERED,ACCEPT=FALSE,CANCEL=FALSE)
		ON ACTION win1 CALL win("form1")
		ON ACTION win2 CALL win("form2")
		ON ACTION win3 CALL win("form3")
		ON ACTION win4 CALL win("form4")
		ON ACTION win5 CALL win("form5")
		ON ACTION close EXIT INPUT
		ON ACTION about CALL about()
		ON ACTION quit EXIT INPUT
	END INPUT

END MAIN
--------------------------------------------------------------------------------
FUNCTION win(l_form STRING)
	DEFINE w ui.Window
	DEFINE n om.DomNode

	DISPLAY "Form:",l_form
	IF m_diag THEN
		OPEN WINDOW w WITH FORM l_form ATTRIBUTE(STYLE="dialog")
	ELSE
		OPEN WINDOW w WITH FORM l_form
	END IF

	LET w = ui.Window.getCurrent()
	LET n = w.findNode("FormField","formonly.date")
	IF n IS NOT NULL THEN
		DISPLAY TODAY TO date
	END IF
	LET n = w.findNode("FormField","formonly.title")
	IF n IS NOT NULL THEN
		DISPLAY "My Title" TO title
	END IF
	LET n = w.findNode("FormField","formonly.logo3")
	IF n IS NOT NULL THEN
		DISPLAY "logo" TO logo3
	END IF

	MENU
		BEFORE MENU
			IF NOT l_form = "form5" THEN
				CALL dialog.setActionHidden("bt_photo", TRUE)
				CALL dialog.setActionHidden("bt_sync", TRUE)
				CALL dialog.setActionHidden("bt_admint", TRUE)
				CALL dialog.setActionHidden("bt_logout", TRUE)
			END IF
		ON ACTION bt_photo MESSAGE "Photo"
		ON ACTION bt_sync MESSAGE "Sync"
		ON ACTION bt_admint MESSAGE "Admin"
		ON ACTION bt_logout MESSAGE "Logout" EXIT MENU
		ON ACTION close EXIT MENU
		ON ACTION back EXIT MENU
	END MENU
	CLOSE WINDOW w
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION about()
	DEFINE ar DYNAMIC ARRAY OF RECORD
		info STRING,
		val STRING
	END RECORD
	LET ar[ ar.getLength() + 1 ].info = %"App ver:" 
	LET ar[ ar.getLength() ].val = c_appver
	LET ar[ ar.getLength() + 1 ].info = %"Client:"
	LET ar[ ar.getLength() ].val = ui.Interface.getFrontEndName()||" "||ui.Interface.getFrontEndVersion()
	LET ar[ ar.getLength() + 1 ].info = %"DVM Ver:"
	LET ar[ ar.getLength() ].val = fgl_getVersion()
	LET ar[ ar.getLength() + 1 ].info = %"IMG Path:"
	LET ar[ ar.getLength() ].val = NVL(fgl_getEnv("FGLIMAGEPATH"),"NULL")
--	LET ar[ ar.getLength() + 1 ].info = "ScreenRes:" 
--	LET ar[ ar.getLength() ].val = 

	OPEN WINDOW about WITH FORM "about"
	DISPLAY ARRAY ar TO arr.* ATTRIBUTES(ACCEPT=FALSE,CANCEL=FALSE)
		BEFORE DISPLAY
			IF ui.Interface.getFrontEndName() != "GMA" THEN
				CALL DIALOG.setActionHidden("gma_about",TRUE)
			END IF
		ON ACTION gma_about CALL ui.interface.frontCall("Android","showAbout",[],[])
		ON ACTION back EXIT DISPLAY
		ON ACTION close EXIT DISPLAY
	END DISPLAY
	CLOSE WINDOW about
END FUNCTION