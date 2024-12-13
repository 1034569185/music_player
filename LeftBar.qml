// pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import "./qcComponent"

Rectangle {
    id: leftBar

    property var findMusicData: { // 发现音乐数据
        "headerText":"发现音乐",
            "btnData": [
                {btnIcon:"qrc:/Images/discoverMusic.svg",btnText:"发现音乐",isActive:true,qml:"pageQml/PageFindMusic.qml"},
                {btnIcon:"qrc:/Images/playList.svg",btnText:"歌单",isActive:true,qml:"pageQml/PageMusicPlayList.qml"},

            ],"isActive" :true
        }
    property var myMusicData: { // 我的音乐数据
        "headerText": "我的音乐",
        "btnData": [
            {btnIcon:"qrc:/Images/myFavorite.svg",btnText:"我喜欢的音乐",isActive:true,qml:"pageQml/PageMusicFavoriteDetail.qml"},
            {btnIcon:"qrc:/Images/folder.svg",btnText:"文件夹",isActive:true,qml:"pageQml/PageLocalFolderDetail.qml"},
            {btnIcon:"qrc:/Images/recentlyPlayed.svg",btnText:"最近播放",isActive:true,qml:"pageQml/PageHistoryRecordDetail.qml"},
            {btnIcon:"qrc:/Images/download.svg",btnText:"下载",isActive:true,qml:"pageQml/PageLocalDownloadDetail.qml"},

            ],
        "isActive": true
    }
    property var myCreatePlaylistData: { // 我创建的歌单数据
        "headerText": "我创建的歌单",
        "btnData": [

        ],
        "isActive": true
    }
    property string thisQml: "pageQml/PageLocalFolderDetail.qml"
    property string thisBtnText: "发现音乐"
    // property string savePlayListInfoPath: "userInfo/playlistInfo.json"
    property int btnHeight: 40
    property int fontSize: 11

    width: 200
    height: parent.height
    color: "#FAF2F1"

    Flickable {
        id: leftBarFlickable
        width: parent.width
        height: parent.height
        contentHeight: height
        contentWidth: width
        Column {
            id: leftBarColumn
            spacing: 10
            ListView { // 发现音乐
                id: findMusicListView
                width: leftBarFlickable.width
                height: contentHeight
                spacing: 3
                interactive: false
                model: leftBar.findMusicData.btnData
                header: Text {
                    width: parent.width
                    height: text === "" ?0: contentHeight +5
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    elide: Text.ElideRight
                    font.pointSize: leftBar.fontSize-1
                    text: leftBar.findMusicData.headerText
                    color: "#572C27"
                }
                delegate: findMusicDelegate
            }
            ListView { // 我的音乐
                id: myMusicListView
                width: leftBarFlickable.width
                height: contentHeight
                spacing: 3
                interactive: false
                model: leftBar.myMusicData.btnData
                header: Text {
                    width: parent.width
                    height: text === "" ?0: contentHeight +5
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    font.pointSize: leftBar.fontSize-1
                    text: leftBar.myMusicData.headerText
                    elide: Text.ElideRight
                    color: "#572C27"
                }
                delegate: myMusicDelegate
            }
            ListView { // 创建的歌单
                id: myCreatePlayListListView
                property var popup: null
                width: leftBarFlickable.width
                height: contentHeight
                spacing: 3
                interactive: false
                model: leftBar.myCreatePlaylistData.btnData
                delegate: createPlayListDelegate
                header: Item {
                    width: parent.width
                    height: children[0].height + 10
                    Text {
                        width: parent.width - 15
                        height: text === "" ? 0: contentHeight
                        elide: Text.ElideRight
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        font.pointSize: leftBar.fontSize-1
                        text: leftBar.myCreatePlaylistData.headerText
                        color: "#572C27"
                    }
                    MouseArea {
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        width: 15
                        height: width
                        cursorShape: Qt.PointingHandCursor

                        Canvas {
                            anchors.fill: parent
                            onPaint: {
                                let ctx = getContext("2d");
                                ctx.strokeStyle = "#572C27";
                                ctx.lineWidth = 1.5;
                                ctx.beginPath();
                                ctx.moveTo(width/2,0)
                                ctx.lineTo(width/2,height);
                                ctx.moveTo(0,height/2)
                                ctx.lineTo(width,height/2);
                                ctx.closePath();
                                ctx.stroke();
                            }

                        }
                    }

                }
            }
        }
    }


    Component { // 发现音乐单项实例
        id: findMusicDelegate
        Rectangle {
            id: findPre
            property bool isHoverd: false
            property bool isThisBtn: leftBar.thisBtnText === leftBar.findMusicData.btnData[index].btnText
            width: leftBarFlickable.width - 15
            height: leftBar.btnHeight
            radius: 50
            color: if(isHoverd) return "#1FFFFFFF"
                   else return "#00000000"
            Rectangle {
                width: parent.isThisBtn ? parent.width : 0
                height: parent.height
                color: if(parent.isThisBtn) return "#2FFFFFFF"
                       else return "#1FFFFFFF"
                radius: parent.radius
                Behavior on width {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Row {
                width: parent.width
                height: parent.height-10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.radius / 4
                spacing: 10
                QCImage {
                    id: icon
                    width: 20
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize: Qt.size(32,32)
                    source: leftBar.findMusicData.btnData[index].btnIcon
                    color: "#572C27"
                }
                Text {
                    width: parent.width
                    height: contentHeight
                    font.pointSize: leftBar.fontSize
                    font.bold: findPre.isThisBtn ? true : false
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                    text: leftBar.findMusicData.btnData[index].btnText
                    color: "#572C27"
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: function (mouse) {
                    if(leftBar.thisBtnText === leftBar.findMusicData.btnData[index].btnText) return

                    let func = () => {
                        leftBar.thisQml = leftBar.findMusicData.btnData[index].qml
                        leftBar.thisBtnText = leftBar.findMusicData.btnData[index].btnText
                    }
                    func()
                    rightContent.push({callBack:func,name: leftBar.findMusicData.btnData[index].btnText,data: {}})
                }
                onEntered: {
                    parent.isHoverd = true
                }
                onExited: {
                    parent.isHoverd = false
                }
            }

            onParentChanged: {
                if(parent != null ) {
                    anchors.horizontalCenter = parent.horizontalCenter
                }
            }
        }

    }
    Component { // 我的音乐单项实例
        id: myMusicDelegate
        Rectangle {
            id: musicPre
            property bool isHoverd: false
            property bool isThisBtn: leftBar.thisBtnText === leftBar.myMusicData.btnData[index].btnText
            width: leftBarFlickable.width - 15
            height: leftBar.btnHeight
            radius: 50
            color: if(isHoverd) return "#1FFFFFFF"
                   else return "#00000000"
            Rectangle {
                width: parent.isThisBtn ? parent.width : 0
                height: parent.height
                color: if(parent.isThisBtn) return "#2FFFFFFF"
                       else return "#1FFFFFFF"
                radius: parent.radius
                Behavior on width {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Row {
                width: parent.width
                height: parent.height-10
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.radius / 4
                spacing: 10
                QCImage {
                    id: icon
                    width: 20
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize: Qt.size(32,32)
                    source: leftBar.myMusicData.btnData[index].btnIcon
                    color: "#572C27"
                }
                Text {
                    width: parent.width - icon.width - parent.spacing
                    height: contentHeight
                    font.pointSize: leftBar.fontSize
                    font.bold: musicPre.isThisBtn ? true : false
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                    text: leftBar.myMusicData.btnData[index].btnText
                    color: "#572C27"
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: function (mouse){
                    if(leftBar.thisBtnText === leftBar.myMusicData.btnData[index].btnText) return

                    let func = () => {
                        leftBar.thisQml = leftBar.myMusicData.btnData[index].qml
                        leftBar.thisBtnText = leftBar.myMusicData.btnData[index].btnText
                    }
                    func()
                    rightContent.push({callBack:func,name: leftBar.myMusicData.btnData[index].btnText,data: {}})
                }
                onEntered: {
                    parent.isHoverd = true
                }
                onExited: {
                    parent.isHoverd = false
                }
            }

            onParentChanged: {
                if(parent != null ) {
                    anchors.horizontalCenter = parent.horizontalCenter
                }
            }
        }

    }
    Component { // 新建歌单单项实例
        id: createPlayListDelegate
        Rectangle {
            id: createPre
            property bool isHoverd: false
            property bool isThisBtn: leftBar.thisBtnText === leftBar.myCreatePlaylistData.btnData[index].btnText
            width: leftBarFlickable.width - 15
            height: leftBar.btnHeight
            radius: 50
            color: if(isHoverd) return "#1FFFFFFF"
                   else return "#00000000"
            Rectangle {
                width: parent.isThisBtn ? parent.width : 0
                height: parent.height
                color: if(parent.isThisBtn) return "#2FFFFFFF"
                       else return "#1FFFFFFF"
                radius: parent.radius
                Behavior on width {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            Row {
                width: parent.width
                height: parent.height-10
                anchors.verticalCenter: parent.verticalCenter
                padding: parent.radius / 4
                spacing: 10
                QCImage {
                    id: icon
                    width: 20
                    height: width
                    anchors.verticalCenter: parent.verticalCenter
                    sourceSize: Qt.size(32,32)
                    source: leftBar.myCreatePlaylistData.btnData[index].btnIcon
                    color: "#572C27"
                }
                Text {
                    width: parent.width - icon.width - parent.spacing - parent.padding
                    height: contentHeight
                    font.pointSize: leftBar.fontSize
                    font.bold: createPre.isThisBtn ? true : false
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                    text: leftBar.myCreatePlaylistData.btnData[index].btnText
                    color: "#572C27"
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: function (mouse){
                    if(leftBar.thisBtnText === leftBar.myCreatePlaylistData.btnData[index].btnText) return

                    let func = () => {
                        leftBar.thisQml = leftBar.myCreatePlaylistData.btnData[index].qml
                        leftBar.thisBtnText = leftBar.myCreatePlaylistData.btnData[index].btnText
                        rightContent.item.playListInfo = MyPlayListManager.data[index]
                    }
                    func()
                    rightContent.push({callBack:func,name: "playList: "+ leftBar.myCreatePlaylistData.btnData[index].btnText,data: {}})
                }
                onEntered: {
                    parent.isHoverd = true
                }
                onExited: {
                    parent.isHoverd = false
                }
            }

            onParentChanged: {
                if(parent != null ) {
                    anchors.horizontalCenter = parent.horizontalCenter
                }
            }
        }

    }

    function getBtnCurrent(name) {
        var thisIndex = 0
        return thisBtnText === name
    }
}
