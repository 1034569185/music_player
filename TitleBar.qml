import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
// import qc.window 1.0

Rectangle {
    id: titleBar
    width: parent.width
    height: 80
    color: "#FAF2F1"

    MouseArea {
        property var click_pos: Qt.point(0,0)
        anchors.fill: parent
        onPositionChanged: function(mouse){
            if( !pressed || window.mouse_pos != FramelessWindow.NORMAL ) return

            if(!window.startSystemMove()){
                var offset = Qt.point(mouseX - click_pos.x, mouseY - click_pos.y)
                window.x += offset.x
                window.y += offset.y
            }

        }

        onPressedChanged: function(mouse){
            click_pos.x = Qt.point(mouseX, mouseY)
        }
        onDoubleClicked: {

            if( window.visibility == Window.Maximized )
                window.showNormal()
            else
                window.showMaximized()
        }

        RowLayout {
            width: parent.width - 20
            height: parent.height - 10
            anchors.centerIn: parent
            Row {
                width: 80
                height: parent.height
                spacing: 15
                Image {
                    width: 40
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/Images/music163.svg"
                    ColorOverlay {
                        anchors.fill: parent
                        source: parent
                        color: "#572920"
                    }

                }
                Text {
                    font.pointSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Music Player Demo"
                    color: "#572920"
                }
                Component.onCompleted: {
                    width = children[0].width + children[1].contentWidth + spacing
                }
            }
            Item {Layout.preferredWidth: 10; Layout.fillWidth: true}

            Search{
                id: searchFrame
            }

            Item {Layout.preferredWidth: 10; Layout.fillWidth: true}
            Row {
                width: 30*3 + 5*3
                spacing: 5
                Rectangle {
                    id: minWindowBtn
                    property bool isHovered: false
                    width: 30
                    height: width
                    radius: 100
                    color: isHovered ? "#1F572920" : "#00000000"
                    Rectangle {
                        width: parent.width - 5
                        anchors.centerIn: parent
                        height: 2
                        border.width: 2
                        border.color: "#572920"
                        color: "#00000000"
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            window.showMinimized()
                        }
                        onEntered: {
                            parent.isHovered = true
                        }
                        onExited: {
                            parent.isHovered = false
                        }
                    }
                }

                Rectangle {
                    id: minMaxWindowBtn
                    property bool isHovered: false
                    width: 30
                    height: width
                    radius: 100
                    color: isHovered ? "#1F572920" : "#00000000"
                    Rectangle {
                        width: parent.width - 5
                        height: width
                        anchors.centerIn: parent
                        radius: 100
                        color: "#00000000"
                        border.width: 1.5
                        border.color: "#572920"
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if(window.visibility == Window.Maximized){
                                window.showNormal()
                            } else {
                                window.showMaximized()
                            }

                        }
                        onEntered: {
                            parent.isHovered = true
                        }
                        onExited: {
                            parent.isHovered = false
                        }
                    }
                }

                Rectangle {
                    id: quitWindowBtn
                    property bool isHovered: false
                    width: 30
                    height: width
                    radius: 100
                    color: isHovered ? "#1F572920" : "#00000000"
                    Rectangle {
                        width: parent.width - 5
                        height: 2
                        border.width: 2
                        border.color: "#572920"
                        anchors.centerIn: parent
                        rotation: 45
                        color: "#572920"
                    }
                    Rectangle {
                        width: parent.width - 5
                        height: 2
                        border.width: 2
                        border.color: "#572920"
                        anchors.centerIn: parent
                        rotation: -45
                        color: "#572920"
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            Qt.quit()
                        }
                        onEntered: {
                            parent.isHovered = true
                        }
                        onExited: {
                            parent.isHovered = false
                        }
                    }
                }


            }
        }


    }
}

