sub init()
    m.grid = m.top.findNode("grid")
    m.shapes = m.top.findNode("shapes")

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
    m.shapes = {
        "X": "x",
        "O": "o"
    }
    m.currentFocus = [0, 0]
    m.isPlayerMove = true
    m.currentShape = m.shapes["X"]
    
    m.width= 1920
    m.height = 1080
    drawGrid()
end sub

function onKeyEvent(key as string, press as boolean) as boolean

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