sub init()
    m.top.setFocus(true)
    m.grid = m.top.findNode("grid")
    m.shapes = m.top.findNode("shapes")
    m.currentFocusPointer = m.top.findNode("currentFocusPointer")
    m.focusAnimation = m.top.findNode("focusAnimation")
    m.focusInterp = m.top.findNode("focusInterp")
    m.cellSize = 300
    m.winLines = [
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [0, 3, 6],
        [1, 4, 7],
        [2, 5, 8],
        [0, 4, 8],
        [2, 4, 6],
    ]
    m.shapeMap = {
        "X": "x",
        "O": "o"
    }
    m.currentFocus = [0, 0]
    m.isPlayerMove = true
    m.currentShape = m.shapeMap["X"]
    m.gameMap = ["","","","","","","","",""]
    m.width = 1920
    m.height = 1080
    m.isGameOver = false
    drawGrid()
    setFocusPointer()
end sub

function onKeyEvent(key as string, press as boolean) as boolean
    if (press = true)
        if (key = "left")
            return moveFocus(-1, 0)
        else if (key ="right")
            return moveFocus(1, 0)
        else if (key ="up")
            return moveFocus(0,-1)
        else if (key ="down")
            return moveFocus(0,1)
        else if (key = "OK")
            setShape()
        end if
    end if
    return false
end function

sub drawGrid()
    gridLines = [
        {
            x: m.width / 2 - m.cellSize * 1.5,
            y: m.height / 2 - m.cellSize * 0.5,
            w: m.cellSize * 3,
            h: 3
        }
        {
            x: m.width / 2 - m.cellSize * 1.5,
            y: m.height / 2 + m.cellSize * 0.5,
            w: m.cellSize * 3,
            h: 3
        }
        {
            x: m.width / 2 - m.cellSize * 0.5,
            y: m.height / 2 - m.cellSize * 1.5,
            w: 3,
            h: m.cellSize * 3
        }
        {
            x: m.width / 2 + m.cellSize * 0.5
            y: m.height / 2 - m.cellSize * 1.5
            w: 3,
            h: m.cellSize * 3
        }

    ]

    for i = 0 to gridLines.count() - 1
        rectangle = m.grid.createChild("Rectangle")
        rectangle.setFields({
            "translation": [
                gridLines[i]["x"],
                gridLines[i]["y"]
            ],
            "width": gridLines[i]["w"],
            "height": gridLines[i]["h"],
            "color": "#000000"
        })
    end for
end sub

sub setFocusPointer()
    m.currentFocusPointer.setFields({
        "translation": [
            (m.width / 2 - m.cellSize * 1.5) + m.currentFocus[0] * m.cellSize + 10,
            (m.height / 2 - m.cellSize * 1.5) + m.currentFocus[1] * m.cellSize + 10
        ],
        "width": m.cellSize - 20
        "height": m.cellSize - 20
        "visible": true
    })
end sub

function moveFocus(dX, dY)
    currentFocusCoords = m.currentFocusPointer.translation
    targetCoords = [currentFocusCoords[0], currentFocusCoords[1]]
    toMove = false
    if (dX <> 0 and m.currentFocus[0] + dX >= 0 and m.currentFocus[0] + dX <= 2)
        targetCoords[0] = currentFocusCoords[0] + m.cellSize * dX
        m.currentFocus[0] = m.currentFocus[0] + dX
        toMove = true
    else if (dY <> 0 and m.currentFocus[1] + dY >= 0 and m.currentFocus[1] + dY <= 2)
        targetCoords[1] = currentFocusCoords[1] + m.cellSize * dY
        m.currentFocus[1] = m.currentFocus[1] + dY
        toMove = true
    end if
    if (toMove = true)
        m.focusInterp.keyValue = [currentFocusCoords, targetCoords]
        m.focusAnimation.control = "start"
    end if
    return true
end function

sub setShape()
    position = m.currentFocus[1] * 3 + m.currentFocus[0]

    if (m.gameMap[position] = "")
        placeShape(position)
    end if
end sub

sub placeShape(position)
    if (m.isGameOver = false)
        m.gameMap[position] = m.currentShape
        cellX = position mod 3
        cellY = position \ 3
        shapePoster = m.shapes.createChild("Poster")

        if (m.currentShape = m.shapeMap["X"])
            posterUri = "pkg://resources/cross.png"
        else
            posterUri = "pkg://resources/nought.png"
        end if
        shapePoster.setFields({
            "translation": [
                (m.width / 2 - m.cellSize * 1.5) + cellX * m.cellSize + 100 ,
                (m.height / 2 - m.cellSize * 1.5) + cellY * m.cellSize + 100
            ],
            "width": 100
            "height": 100,
            "uri": posterUri
        })
    end if
end sub