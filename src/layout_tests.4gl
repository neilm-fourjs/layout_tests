DEFINE m_diag BOOLEAN
CONSTANT c_appver = "1.0"
MAIN

	OPEN FORM f FROM "form"
	DISPLAY FORM f

	INPUT BY NAME m_diag ATTRIBUTE(UNBUFFERED,ACCEPT=FALSE,CANCEL=FALSE)
		ON ACTION win1 CALL win("form1")
		ON ACTION win2 CALL win("form2")
		ON ACTION win3 CALL win("form3")
		ON ACTION win4 CALL win("form4")
		ON ACTION close EXIT INPUT
		ON ACTION about CALL about()
		ON ACTION quit EXIT INPUT
	END INPUT

END MAIN
--------------------------------------------------------------------------------
FUNCTION win(l_form STRING)
	DEFINE w ui.Window
	DEFINE n om.DomNode

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
		ON ACTION close EXIT MENU
		ON ACTION exit EXIT MENU
	END MENU
	CLOSE WINDOW w
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION about()
	DEFINE ar DYNAMIC ARRAY OF RECORD
		info STRING,
		val STRING
	END RECORD
	LET ar[ ar.getLength() + 1 ].info = "App ver:" LET ar[ ar.getLength() ].val = c_appver
	LET ar[ ar.getLength() + 1 ].info = "Client:" LET ar[ ar.getLength() ].val = ui.Interface.getFrontEndName()||" "||ui.Interface.getFrontEndVersion()
	LET ar[ ar.getLength() + 1 ].info = "DVM Ver:" LET ar[ ar.getLength() ].val = fgl_getVersion()
	LET ar[ ar.getLength() + 1 ].info = "IMG Path:" LET ar[ ar.getLength() ].val = NVL(fgl_getEnv("FGLIMAGEPATH"),"NULL")
--	LET ar[ ar.getLength() + 1 ].info = "ScreenRes:" LET ar[ ar.getLength() ].val = 

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