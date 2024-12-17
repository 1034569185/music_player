import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import QtQuick.Controls
import QtCore

// import qc.window 1.0
// import qc.ms 1.0


FramelessWindow {
    id: window
    x: 420
    y: 150
    width: 1010
    height: 710
    minimumWidth: 1010
    minimumHeight: 710
    color: "#2F000000"
    visible: true
    title: qsTr("Hello World")

    // Button {
    //          text: "Open"
    //          onClicked: popup.open()
    //          z: 10
    //      }

     // Popup {
     //     id: popup
     //     x: 100
     //     y: 100
     //     width: 200
     //     height: 300
     //     modal: true
     //     focus: true
     //     closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
     //     Image {
     //         source:  "data:image/png;base64," + m_music_Player.coverImage
     //     }
     // }

    MusicPlayer {
        id: m_music_Player
        // isPaused: true
    }

    MyUtility {
        id: ul
    }

    MetaManager{
        id: metaHandle
    }

    Column{
        anchors.fill: parent
        TitleBar{
            id: titleBar
            width: parent.width
            height: 80
            color: "#FAF2F1"
        }

        Rectangle {
            id: content
            width: parent.width
            height: window.height - titleBar.height - bottomBar.height
            Row {
                width: parent.width
                height: parent.height
                LeftBar {
                    id: leftBar
                }
                RightContent {
                    id: rightContent
                    width: parent.width - leftBar.width
                    height: parent.height
                    thisQml: leftBar.thisQml
                }
            }
        }

        BottomBar {
            id: bottomBar
            width: parent.width
            height: 80
        }
    }




}

