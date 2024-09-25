sub main(args as object)


    m.port = createObject("roMessagePort")
    m.screen = createObject("roSGScreen")

    m.screen.setMessagePort(m.port)
    m.scene = m.screen.createScene("MainScene")
    m.screen.show()

    m.scene.observeField("exitApp", m.port)


    while(true)
        msg = wait(0, m.port)
        msgType = type(msg)
        if msgType = "roSGScreenEvent"
            if msg.isScreenClosed() then return
        else if msgType = "roSGNodeEvent"
            handleSGNodeEvent(msg)
        end if
    end while
end sub

sub handleSGNodeEvent(msg as Object)
    field = msg.getField()

    if (msg.getField() = "exitApp" and msg.getData())
        m.screen.close()
    end if
end sub