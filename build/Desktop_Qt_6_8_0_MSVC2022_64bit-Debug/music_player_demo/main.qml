import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Layouts
import QtQuick.Controls
import QtCore
// import qc.window 1.0


FramelessWindow {
    id: window
    width: 1010
    height: 710
    minimumWidth: 1010
    minimumHeight: 710
    color: "#2F000000"
    visible: true
    title: qsTr("Hello World")

    QCMusicPlayer {
        id: p_music_Player
    }

    MusicPlayer {
        id: m_musci_Player
        isPaused: true
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

