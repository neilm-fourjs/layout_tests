DEFINE m_diag BOOLEAN
CONSTANT c_appver = "1.0"

CONSTANT c_f1 = "A simple centered icon with a title below it."
CONSTANT c_f2 = "A title area with a logo, title and date. The text should be centered the image to left and the date to the right"
CONSTANT c_f3 = "An icon and date to the right of the screen and a title to the left."
CONSTANT c_f4 = "Various icons and text tests in a single form."
CONSTANT c_f5 = "Pad form so the buttons are at the bottom of the screen."
CONSTANT c_f6 = "Pad form with centered items and bottom of the screen."
CONSTANT c_f7 = "Image sizing 1"
CONSTANT c_f8 = "Image sizing 2"
DEFINE m_tests DYNAMIC ARRAY OF STRING
MAIN
	LET m_tests[1] = c_f1
	LET m_tests[2] = c_f2
	LET m_tests[3] = c_f3
	LET m_tests[4] = c_f4
	LET m_tests[5] = c_f5
	LET m_tests[6] = c_f6
	LET m_tests[7] = c_f7
	LET m_tests[8] = c_f8

	OPEN FORM f FROM "form"
	DISPLAY FORM f
	CALL extend_form()

--	CALL ui.Form.setDefaultInitializer("form_init")

	INPUT BY NAME m_diag ATTRIBUTE(UNBUFFERED,ACCEPT=FALSE,CANCEL=FALSE)
		ON ACTION win1 CALL win("form1")
		ON ACTION win2 CALL win("form2")
		ON ACTION win3 CALL win("form3")
		ON ACTION win4 CALL win("form4")
		ON ACTION win5 CALL win("form5")
		ON ACTION win6 CALL win("form6")
		ON ACTION win7 CALL win("form7")
		ON ACTION win8 CALL win("form8")
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
	LET n = w.findNode("FormField","formonly.connected")
	IF n IS NOT NULL THEN
		DISPLAY "You not connected to a network" TO connected
	END IF

	MENU
		BEFORE MENU
			IF NOT l_form = "form5" THEN
				CALL dialog.setActionHidden("bt_sync", TRUE)
				CALL dialog.setActionHidden("bt_logout", TRUE)
			END IF
		ON ACTION bt_sync MESSAGE "Sync"
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
--------------------------------------------------------------------------------
-- experimental code to try and force a space size
FUNCTION form_init(f ui.Form)
	DEFINE n, fn, gn om.DomNode
	DEFINE nl om.NodeList
	DEFINE x SMALLINT
	DEFINE l_height, l_formHeight, l_gridHeight SMALLINT
	DEFINE l_nam STRING

	LET fn = f.getNode()
	CALL fn.writeXml("form.xml")
	LET l_formHeight = fn.getAttribute("height")
	DISPLAY "formHeight:", l_formHeight

	LET nl = fn.selectByTagName("Image")
	FOR x = 1 TO nl.getLength()
		LET n = nl.item(x)
		LET l_nam = n.getAttribute("name")
		IF l_nam.subString(1,6) != "spacer" THEN CONTINUE FOR END IF

		LET gn = n.getParent()
		LET l_gridheight = gn.getAttribute("height")
		DISPLAY "gridHeight:", l_gridheight

		LET l_height = n.getAttribute("height")
		DISPLAY "height:", l_height

		--CALL n.setAttribute("gridHeight",l_height)

		IF l_gridHeight IS NOT NULL AND l_gridHeight != 0 THEN
		--	CALL gn.setAttribute("height", l_gridHeight + l_height )
			CALL fn.setAttribute("height", l_formHeight + l_height )
		END IF

		LET l_gridHeight = gn.getAttribute("height")
		DISPLAY "New gridHeight:", l_gridHeight
	END FOR

	LET l_formHeight = fn.getAttribute("height")
	DISPLAY "New formHeight:", l_formHeight

	LET fn = f.getNode()
	CALL fn.writeXml("form_after.xml")
END FUNCTION
--------------------------------------------------------------------------------
FUNCTION extend_form()
	DEFINE w ui.Window
	DEFINE n,g,n1 om.DomNode
	DEFINE x SMALLINT
	LET w = ui.Window.getCurrent()
	LET n = w.findNode("Grid","tests")
	FOR x = 1 TO m_tests.getLength()
		LET g = n.createChild("Group")
		CALL g.setAttribute("posY",x)
		LET n1 = g.createChild("FormField")
		CALL n1.setAttribute("name","formonly.f"||x)
		CALL n1.setAttribute("value", m_tests[x])
		CALL n1.setAttribute("colName","f"||x)
		LET n1 = n1.createChild("TextEdit")
		CALL n1.setAttribute("posY",x)
		CALL n1.setAttribute("height",3)
		CALL n1.setAttribute("gridHeight",3)
		CALL n1.setAttribute("scrollBars","none")
		CALL n1.setAttribute("stretch","both")
		CALL n1.setAttribute("style","noborder")
		LET n1 = g.createChild("Button")
		CALL n1.setAttribute("name","win"||x)
		CALL n1.setAttribute("posY",x+4)
	END FOR
END FUNCTION