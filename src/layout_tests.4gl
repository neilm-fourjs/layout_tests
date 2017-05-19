
IMPORT util
IMPORT os

CONSTANT c_appver = "2.0"

DEFINE m_diag BOOLEAN
DEFINE j RECORD m_tests DYNAMIC ARRAY OF RECORD 
			name STRING,
			desc STRING,
			img STRING
		END RECORD
	END RECORD
DEFINE m_dialog ui.Dialog
DEFINE m_fields DYNAMIC ARRAY OF RECORD
		name STRING,
		type STRING
	END RECORD

MAIN
	DEFINE x SMALLINT
	DEFINE l_event STRING

	CALL setup_tests()

	OPEN FORM f FROM "form"
	DISPLAY FORM f
	CALL extend_form()

--	CALL ui.Form.setDefaultInitializer("form_init")

  CALL ui.Dialog.setDefaultUnbuffered(TRUE)
	LET m_fields[1].name = "m_diag"
	LET m_fields[1].type = "BOOLEAN"
  LET m_dialog = ui.Dialog.createInputByName(m_fields)

  CALL m_dialog.addTrigger("ON ACTION close")
  CALL m_dialog.addTrigger("ON ACTION about")
  CALL m_dialog.addTrigger("ON ACTION quit")

	FOR x = 1 TO j.m_tests.getLength() 
  	CALL m_dialog.addTrigger("ON ACTION win"||x)
	END FOR
  LET int_flag = FALSE
  WHILE NOT int_flag
		LET l_event = m_dialog.nextEvent()
--                                1234567890123
		IF l_event.subString(1,13) = "ON ACTION win" THEN
			CALL win("form"||l_event.subString(14, l_event.getLength() ))
			CONTINUE WHILE
		END IF
    CASE l_event
      WHEN "ON ACTION quit"
        LET int_flag = TRUE
        EXIT WHILE
      WHEN "ON ACTION close"
        LET int_flag = TRUE
        EXIT WHILE
      WHEN "ON ACTION about" CALL about()
		END CASE
	END WHILE

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
	LET n = w.findNode("FormField","formonly.footer")
	IF n IS NOT NULL THEN
		DISPLAY "(c) Four Js Developement Tools" TO footer
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
	FOR x = 1 TO j.m_tests.getLength()
		LET g = n.createChild("Group")
		CALL g.setAttribute("posY",x)
		LET n1 = g.createChild("FormField")
		CALL n1.setAttribute("name","formonly.f"||x)
		CALL n1.setAttribute("value", j.m_tests[x].desc)
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
		CALL n1.setAttribute("text",j.m_tests[x].name)
		CALL n1.setAttribute("image",j.m_tests[x].img)
		CALL n1.setAttribute("posY",x+4)
	END FOR
END FUNCTION
--------------------------------------------------------------------------------
-- Get the list of tests from a JSON file.
FUNCTION setup_tests()
	DEFINE l_jo util.JSONObject
	DEFINE l_line STRING
	DEFINE c base.Channel
	
	LET l_line = fgl_getEnv("TESTPATH")
	IF l_line.getLength() > 0 THEN 
		LET l_line = os.path.join(l_line,"tests.json")
	ELSE
		LET l_line = "tests.json"
	END IF
	DISPLAY "Test File:",l_line
	LET c = base.Channel.create()
	TRY
		CALL c.openFile(l_Line,"r")
	CATCH
		CALL fgl_winMEssage("Error",SFMT("Failed to load %1",l_line),"exclamation")
		EXIT PROGRAM
	END TRY
	LET l_line = NULL
	WHILE NOT c.isEof()
		LET l_line = l_line.append( c.readLine() )
	END WHILE
	CALL c.close()
	LET l_jo = util.JSONObject.parse( l_line )

	--DISPLAY l_jo.toString()

	CALL l_jo.toFGL( j )
END FUNCTION