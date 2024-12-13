import QtQuick
import Qt5Compat.GraphicalEffects
import QtQuick.Controls
import Qt.labs.platform
import "../"
import "../qcComponent"
import "../theme"

Item {
    anchors.fill: parent

    FolderDialog {
        id: fd

        onFolderChanged: {
            var filelist = ul.showFiles(folder)
            for( let k of filelist ){
                print(k)
                myListModel.append( { name: k, author: "未知", src: "local", duration: "00:00" } )
            }

        }
    }

    ListModel {
          id: myListModel
      }

    Column {
        anchors.fill: parent
        padding: 3

        Rectangle {
            id: header
            width: parent.width
            height: 60
            color: "#FAF2F1"

            Text {
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 20
                text: qsTr("文件夹")
                color: "#572C27"
                font.pointSize: 20
            }
            Rectangle {
                width: 50
                height: width
                x: 110
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
            id: secondLine
            width: parent.width
            height: 20
            color: "#FAF2F1"
            property var count: 0
            Text {
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 20
                text: "当前已添加" + secondLine.count + "文件夹"
                color: "#572C27"
                font.pointSize: 10
            }
        }

        Rectangle {
            id: trans
            width: parent.width
            height: 60
            color: "#FAF2F1"
            Text {
                id: all
                anchors.verticalCenter: parent.verticalCenter
                x: 20
                text: "全部"
                property bool isSelected: true
                color: isSelected ? "#572C27" : "grey"
                font.pointSize: 14
                font.bold: isSelected

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        cursorShape = Qt.PointingHandCursor
                    }

                    onClicked: {
                        parent.isSelected = true
                        sigle.isSelected = false
                    }
                }
            }
            Text {
                id: sigle
                anchors.left: all.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                text: "文件夹"
                property bool isSelected: false
                color: isSelected ? "#572C27" : "grey"
                font.bold: isSelected
                font.pointSize: 14

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        cursorShape = Qt.PointingHandCursor
                    }

                    onClicked: {
                        parent.isSelected = true
                        all.isSelected = false
                    }
                }
            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 30
                // rightPadding: 20
                text: "Edit"
                color: "#572C27"
                font.pointSize: 13

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        cursorShape = Qt.PointingHandCursor
                    }

                    onClicked: {

                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height - header.height - secondLine.height - trans.height
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
                    // GradientStop { position: 0.0; color: "#3980c7" }
                    // GradientStop { position: 1.0; color: "#a076a5" }
                    GradientStop { position: 0.0; color: Qt.rgba(0.223, 0.501, 0.78, 0.3) }  // 半透明蓝色
                    GradientStop { position: 1.0; color: Qt.rgba(0.627, 0.462, 0.647, 0.3) }  // 半透明紫色
                }
                z: 10
            }



            ListView {
                anchors.fill: parent
                anchors.leftMargin: 15
                anchors.topMargin: 10
                anchors.rightMargin: 15
                clip: true
                snapMode: ListView.SnapOneItem

                model: myListModel
                //     ListModel {
                //     ListElement { name: "Item 1"; author: "未知"; src: "local"; duration: "00:00" }
                //     ListElement { name: "Item 2"; author: "未知"; src: "local"; duration: "01:00" }
                //     ListElement { name: "Item 2"; author: "未知"; src: "local"; duration: "02:00" }
                // }

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

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            propagateComposedEvents: true
                            onEntered: {
                                parent.isHovered = true;
                            }

                            onExited: {
                                if( fav.isHovered == true ) return
                                parent.isHovered = false;
                            }
                            onClicked: {

                            }
                            onDoubleClicked: {
                                var pre = fd.folder.toString()
                                var para = pre.substring(8).concat('/', model.name)
                                print(para)
                                m_music_Player.m_setSource(para)
                                m_music_Player.m_play()
                            }
                        }

                        Row {
                            anchors.fill: parent
                            property real benchmark: (parent.width - idx.width - fav.width - name.width - author.width - duration.width) / 3.7
                            Text {
                                id: idx
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 10
                                text: index + 1
                                font.pointSize: 15
                            }
                            QCImage{
                                id: fav
                                width: 17
                                height: 17
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: idx.right
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
                                anchors.left: fav.right
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
                                text: model.src
                                font.pointSize: 15
                            }
                            Text {
                                id: duration
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: src.right
                                anchors.leftMargin: parent.benchmark
                                text: model.duration
                                font.pointSize: 15
                            }
                        }



                    }

                }
            }

        }


    }


}
