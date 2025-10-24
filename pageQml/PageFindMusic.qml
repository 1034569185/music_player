import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import Qt.labs.platform
import "../qcComponent"
import "../"

Item {
    id: findMusicPage
    anchors.fill: parent

    Component.onCompleted: {
        metaHandle.mode = "online"
    }

    FolderDialog {
        id: fd

        onFolderChanged: {
            ul.downloadPath = fd.folder
        }
    }

    Rectangle {
        id: folderPos
        width: parent.width
        height: 60
        color: "#FAF2F1"

        Text {
            anchors.verticalCenter: parent.verticalCenter
            leftPadding: 10
            text: qsTr("下载位置")
            color: "#572C27"
            font.pointSize: 20
        }
        Rectangle {
            width: 50
            height: width
            x: 118
            radius: 100
            anchors.verticalCenter: parent.verticalCenter
            color: "#FAF2F1"
            QCImage {
                id: icon
                width: parent.width * 0.6
                height: parent.height * 0.6
                anchors.centerIn: parent
                sourceSize: Qt.size(64,64)
                source: "qrc:/Images/folder.svg"
                color: "#572C27"
            }

            MouseArea{
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    cursorShape = Qt.PointingHandCursor
                    parent.color = "lightpink"

                }

                onExited: {
                    parent.color = "#FAF2F1"
                }
                onClicked: {
                    fd.open();
                }
            }
        }
    }

    Rectangle {
        width: parent.width
        height: parent.height - 60
        anchors.top: folderPos.bottom
        border.width: 3
        border.color: "hotpink"
        radius: 13
        color: "transparent"

        LinearGradient {
            width: parent.width * 0.992
            height: parent.height * 0.992
            anchors.centerIn: parent  // 使得矩形居中
            start: Qt.point(0, 0)
            end: Qt.point(300, 300)
            gradient: Gradient {
                GradientStop { position: 0.0; color: Qt.rgba(0.223, 0.501, 0.78, 0.3) }  // 半透明蓝色
                GradientStop { position: 1.0; color: Qt.rgba(0.627, 0.462, 0.647, 0.3) }  // 半透明紫色
            }
            z: 10
        }
        ListView {
            id: listV
            anchors.fill: parent
            anchors.leftMargin: 15
            anchors.topMargin: 10
            anchors.rightMargin: 15
            clip: true
            snapMode: ListView.SnapOneItem

            ScrollBar.vertical: ScrollBar {
                width: 10
                size: 0.02
                snapMode: ScrollBar.SnapAlways
            }

            model: window.modelData

            spacing: 10

            delegate: Item {
                width: parent.width
                height: 70
                Rectangle {
                    id: backg
                    anchors.fill: parent
                    // border.width: 1
                    // border.color: "red"
                    radius: 9
                    property bool isHovered: false
                    color: isHovered ? "skyblue" : "white"

                    Menu {
                        id: contentMenu

                        MenuItem{
                            text: "下载"
                            onTriggered:{
                                // print(model.url, model.name)
                                ul.download(model.url, model.name)

                            }
                        }
                    }

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        propagateComposedEvents: true
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onEntered: {
                            parent.isHovered = true;
                        }

                        onExited: {
                            if( favi.isHovered == true ) return
                            parent.isHovered = false;
                        }
                        onClicked: {
                            if(mouse.button == Qt.RightButton)
                            {
                                contentMenu.open()
                                contentMenu.popup(mouse.x, mouse.y)
                            }
                        }
                        onDoubleClicked: {
                            m_music_Player.m_setSource(model.url)
                            m_music_Player.m_play()
                            metaHandle.cur = index
                        }
                    }

                    Row {
                        anchors.fill: parent
                        property real benchmark: (parent.width - idxs.width - favi.width - name.width - author.width - duration.width) / 3.7
                        Text {
                            id: idxs
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            text: index + 1
                            font.pointSize: 15
                        }
                        QCImage{
                            id: favi
                            width: 17
                            height: 17
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: idxs.right
                            anchors.leftMargin: 5
                            sourceSize: Qt.size(64,64)
                            source: "qrc:/Images/myFavorite.svg"
                            color: "#572C27"
                            property bool isHovered: false
                            MouseArea{
                                anchors.fill: parent
                                hoverEnabled: true
                                propagateComposedEvents: true
                                onEntered: {
                                    cursorShape = Qt.PointingHandCursor
                                    parent.isHovered = true;
                                }
                                onExited: {
                                    parent.isHovered = false
                                }

                                onClicked:  {

                                }
                            }
                        }

                        Text {
                            id: name
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: favi.right
                            anchors.leftMargin: 10
                            text: model.name
                            font.pointSize: 15
                        }
                        Text {
                            id: author
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: name.right
                            anchors.leftMargin: parent.benchmark
                            text: model.author
                            font.pointSize: 15
                        }
                        Text {
                            id: src
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: author.right
                            anchors.leftMargin: parent.benchmark
                            text: "online"
                            font.pointSize: 15
                        }
                        Text {
                            id: duration
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: src.right
                            anchors.leftMargin: parent.benchmark
                            text: "暂无"
                            font.pointSize: 15
                        }
                    }



                }

            }
        }
    }
}
