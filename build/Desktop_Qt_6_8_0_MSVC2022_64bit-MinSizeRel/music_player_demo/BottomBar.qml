import QtQuick
import QtQuick.Controls
import "./theme/"
import "./qcComponent/"

Rectangle {
    id: bottomBar
    property int fontSize: 11
    property string fontFamily: "黑体"
    width: parent.width
    height: 80
    color: "#FAF2F1"

    function setHeight(children,spacing) {
        var h = 0
        for(var i = 0;i < children.length;i++) {
            if(children[i] instanceof Text) {
                h += children[i].contentHeight
            } else {
                h += children[i].height
            }
        }
        h += (children.length-1) *spacing
//        console.log("height: " + h)
        return h
    }

    Slider {
        id: bottomBarSlider
        property bool isMovePressed: false
        width: parent.width
        height: 5
        from: 0
        to: m_music_Player.duration
        anchors.bottom: parent.top
        background: Rectangle {
            color: "#1FFF5966"
            Rectangle {
                width: m_music_Player.bufferProgress * parent.width
                height: parent.height
                color: "#2FFF5966"
            }
            Rectangle {
                width: bottomBarSlider.visualPosition * parent.width
                height: parent.height
                color: "#FFFF5966"
            }


            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    bottomBarSlider.height = 8
                }
                onExited: {
                    bottomBarSlider.height = 5
                }
            }
        }
        handle: Rectangle {
            z: 2
            id: handle
            implicitWidth: 20
            implicitHeight: width
            x: (bottomBarSlider.availableWidth - width)*bottomBarSlider.visualPosition
            y: -((height - bottomBarSlider.height)/2)
            color: bottomBarSlider.pressed ? "#FF5966" :  "#FFFFFF"
            border.width: 1.5
            border.color: "#FF5966"
            radius: 100
        }

        onMoved: {
            isMovePressed = true
        }
        onPressedChanged: {
            if(isMovePressed && pressed === false) {
                m_music_Player.position = value
                isMovePressed = pressed
            }
        }

        onValueChanged: {
            var h = parseInt(value / 1000 / 3600)
            h = h ? h : ""
            var m = parseInt(value / 1000 / 60)
            m = m < 10 ? "0"+ m : m
            var s = parseInt(value / 1000 % 60)
            s = s < 10 ? "0" + s : s
            // print(value)
            cur.text = h !== "" ? h+":" : h + m +":" + s;
        }

        onToChanged: {
            var h = parseInt(to / 1000 / 3600)
            h = h ? h : ""
            var m = parseInt(to / 1000 / 60)
            m = m < 10 ? "0"+ m : m
            var s = parseInt(to / 1000 % 60)
            s = s < 10 ? "0" + s : s
            // print(to)
            dst.text = "/" + h !== "" ? h+":" : h + m +":" + s
        }

        Connections {
            target: m_music_Player
            enabled: !bottomBarSlider.pressed
            function onPositionChanged() {
                bottomBarSlider.value = m_music_Player.position
            }
        }
    }

    Item {
        width: parent.width - 20
        height: parent.height - 15
        anchors.centerIn: parent

        Row {
            id: bottomBarLeft
            width: parent.width*.3
            height: parent.height
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 10
            visible: m_music_Player.name
            RoundImage {
                id: bottomBarCoverImg
                width: parent.height
                height: width
                source:  "data:image/png;base64," + m_music_Player.coverImage
                visible: true
                // Connections {
                //     target: m_music_Player
                //     function onMetaDataChanged() {
                //         print(m_music_Player.coverImage)
                //     }
                // }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if(musicLyricPage.isShow) {
                            musicLyricPage.hidePage()
                        } else {
                            musicLyricPage.showPage()
                        }
                    }
                }
            }
            Column {
                width: parent.width - bottomBarCoverImg.width - parent.spacing*2
                anchors.verticalCenter: bottomBarCoverImg.verticalCenter
                spacing: 3
                Row { // 歌曲名 喜欢按钮
                    width: parent.width
                    height: 35
                    spacing: 5
                    MouseArea {
                        property real maxWidth: parent.width - 35
                        width: nameList.minWidth > maxWidth ? maxWidth : nameList.minWidth
                        height: children[0].height
                        anchors.verticalCenter: parent.verticalCenter
                        clip: true
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: {
                            if(musicLyricPage.isShow) {
                                musicLyricPage.hidePage()
                            } else {
                                musicLyricPage.showPage()
                            }
                        }

                        onEntered: {
                            if(nameList.minWidth > maxWidth) {
                                bottomBarNameTextAni.to = nameList.itemAtIndex(1).x
                                bottomBarNameTextAni.duration = 4000
                                bottomBarNameTextAni.start()
                            }

                        }
                        ListView {
                            id: nameList
                            property real minWidth: contentWidth/2 - spacing/2
                            width: contentWidth
                            spacing: 20
                            model: 2
                            orientation: ListView.Horizontal
                            delegate: Text {
                                id: bottomBarNameText
                                width: contentWidth
                                height: contentHeight
                                font.pointSize: bottomBar.fontSize
                                text: m_music_Player.name
                                color: "#572C27"
                                onContentHeightChanged: function (contentHeight){
                                    nameList.height = contentHeight
                                }
                            }
                        }

                        // Connections {
                        //     target: m_music_Player
                        //     function onThisPlayMusicInfoChanged() {
                        //         bottomBarNameTextAni.stop()
                        //         favoriteBtn.isFavorite = FavoriteManager.favoriteIndexOf(m_music_Player.thisPlayMusicInfo.id) < 0 ? false : true
                        //     }
                        // }
                        NumberAnimation {
                            id: bottomBarNameTextAni
                            target: nameList
                            property: "contentX"
                            from: 0
                            easing.type: Easing.Linear
                            onStopped: {
                                nameList.contentX = 0
                            }
                        }


                    }
                    QCToolTipButton {
                        id: favoriteBtn
                        property bool isFavorite: false
                        width: 35
                        height: width
                        cursorShape: Qt.PointingHandCursor
                        iconSource: if(isFavorite) return "qrc:/Images/myFavorite2.svg"
                        else return "qrc:/Images/myFavorite.svg"
                        iconColor: "#FF5966"
                        hovredColor: "#00000000"
                        color: "#00000000"
                        anchors.verticalCenter: parent.verticalCenter
                        onClicked: {
                            let id = m_music_Player.thisPlayMusicInfo.id
                            if(isFavorite) {
                                isFavorite = false
                                FavoriteManager.remove(id)
                                iconSource = "qrc:/Images/myFavorite.svg"
                            } else {
                                isFavorite = true
                                FavoriteManager.append(m_music_Player.thisPlayMusicInfo)
                                iconSource = "qrc:/Images/myFavorite2.svg"
                            }
                        }
                        Component.onCompleted: {
                            isFavorite = FavoriteManager.favoriteIndexOf(m_music_Player.thisPlayMusicInfo.id) < 0 ? false : true
                        }
                    }

                    // Connections {
                    //     target: m_music_Player
                    //     function onThisPlayMusicInfoChanged() {
                    //         favoriteBtn.isFavorite = FavoriteManager.favoriteIndexOf(m_music_Player.thisPlayMusicInfo.id) < 0 ? false : true
                    //     }
                    // }
                }

                MouseArea { // 作者名
                    property real maxWidth: parent.width
                    property real childWidth: children[0].width
                    width: artistsLists.minWidth > maxWidth ? maxWidth : artistsLists.minWidth
                    height: artistsLists.height
                    hoverEnabled: true
                    clip: true
                    onEntered: {
                        if(artistsLists.minWidth > maxWidth) {
                            bottomBarArtistTextAni.to = artistsLists.itemAtIndex(1).x
                            bottomBarArtistTextAni.duration = 4000
                            bottomBarArtistTextAni.start()
                        }
                    }
                    ListView {
                        id: artistsLists
                        property real minWidth: contentWidth / 2 - spacing/2
                        width: contentWidth
                        model: 2
                        spacing: 20
                        orientation: ListView.Horizontal
                        delegate: Text {
                            id: artistsText
                            clip: true
                            anchors.verticalCenter: parent.verticalCenter
                            font.weight: 2
                            font.pointSize: fontSize - 1
                            text: m_music_Player.artist
                            color: "#572C27"
                            //: "#AF2C27"

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    let lb = leftBar
                                    let rc = rightContent
                                    let getArtistInfo = m_music_Player.thisPlayMusicInfo.artists[index]
                                    var func = () => {
                                        lb.thisBtnText = ""
                                        rc.thisQml = "pageQml/PageArtistsDetail.qml"
                                        rc.item.getArtistInfo = getArtistInfo
                                    }
                                    func()
                                    rightContent.push({callBack:func,name:"artist: "+ getArtistInfo.name ,data: {}})
                                }
                                onEntered: {
                                    parent.isHoverd = true
                                }
                                onExited: {
                                    parent.isHoverd = false
                                }
                            }
                            }



                        }
                    }

                    NumberAnimation {
                        id: bottomBarArtistTextAni
                        target: artistsLists
                        property: "contentX"
                        duration: 0
                        from: 0
                        easing.type: Easing.Linear
                        onStopped: {
                            artistsLists.contentX = 0
                        }
                    }
                    // Connections {
                    //     target: m_music_Player
                    //     function onThisPlayMusicInfoChanged() {
                    //         bottomBarArtistTextAni.stop()
                    //     }
                    // }

                }

                Component.onCompleted: {
                    var h = 0
                    for(var i = 0; i < children.length;i++) {
                        if(children[i] instanceof Text) {
                            h += children[i].contentHeight
                        } else h += children[i]
                    }
                    height = h + spacing
                }
            }
        }

        Row {
            width: parent.width*.3
            height: 35
            anchors.centerIn: parent
            spacing: 10
            QCToolTipButton {
                id: musicPlayModeIcon
                width: 35
                height: width
                cursorShape: Qt.PointingHandCursor
                iconSource: "qrc:/Images/loopPlay.svg"
                hovredColor: "#0FFF5966"
                iconColor: "#FF5966"
                toolTip.border.color: "BLACK"
                onClicked: function (mouse){
                    m_music_Player.setPlayerModel()
                }
                Component.onCompleted: {
                    musicPlayModeIcon.selectPlayMode(m_music_Player.playMode)
                }

                // Connections {
                //     target: m_music_Player
                //     function onPlayModeChanged () {
                //         musicPlayModeIcon.selectPlayMode(m_music_Player.playMode)
                //     }
                // }

                function selectPlayMode(mode) {
                    switch(mode) {
                        case QCMusicPlayer.PlayerMode.ONELOOPPLAY:
                            musicPlayModeIcon.text = "单曲循环"
                            musicPlayModeIcon.iconSource = "qrc:/Images/repeatSinglePlay.svg"
                        break
                        case QCMusicPlayer.PlayerMode.LOOPPLAY:
                            musicPlayModeIcon.text = "列表循环"
                            musicPlayModeIcon.iconSource = "qrc:/Images/loopPlay.svg"
                        break
                        case QCMusicPlayer.PlayerMode.RANDOMPLAY:
                            musicPlayModeIcon.text = "随机播放"
                            musicPlayModeIcon.iconSource = "qrc:/Images/randomPlay.svg"
                        break
                        case QCMusicPlayer.PlayerMode.PLAYLISTPLAY:
                            musicPlayModeIcon.text = "顺序播放"
                            musicPlayModeIcon.iconSource = "qrc:/Images/playListPlay.svg"
                        break
                    }
                }

            }
            QCToolTipButton {
                width: 35
                height: width
                cursorShape: Qt.PointingHandCursor
                iconSource: "qrc:/Images/prePlayer.svg"
                hovredColor: "#1FFF5966"
                iconColor: "#FF5966"
                onClicked: function (mouse) {
                    m_music_Player.preMusicPlay()
                }
            }
            QCToolTipButton {
                width: 35
                height: width
                cursorShape: Qt.PointingHandCursor
                color: "#FF5966"
                iconSource: (!m_music_Player.isPaused) ? "qrc:/Images/stop.svg" : "qrc:/Images/player.svg"
                hovredColor: "#FF5966"
                iconColor: "#FFFFFF"
                transformOrigin: Item.Center
                onClicked: function (mouse) {
                    if(m_music_Player.isPaused) {
                        m_music_Player.m_play()
                    } else {
                        m_music_Player.m_pause()
                    }
                    print(iconSource)
                }
                onEntered: {
                    scale = 1.2
                }
                onExited: {
                    scale = 1
                }

                Behavior on scale {
                    ScaleAnimator {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }
            QCToolTipButton {
                width: 35
                height: width
                cursorShape: Qt.PointingHandCursor
                iconSource: "qrc:/Images/prePlayer.svg"
                hovredColor: "#1FFF5966"
                iconColor: "#FF5966"
                transformOrigin: Item.Center
                rotation: 180
                onClicked: function (mouse) {
                    m_music_Player.nextMusicPlay()
                }
            }
            QCToolTipButton {
                id: desktopLyricBtn

                width: 35
                height: width
                cursorShape: Qt.PointingHandCursor
                iconSource: "qrc:/Images/lyric.svg"
                hovredColor: "#1FFF5966"
                iconColor: if(window.desktopLyric && window.desktopLyric.visible) return "#FF5966"
                else return "#7FFF5966"
                transformOrigin: Item.Center
                rotation: 0
                onClicked: function (mouse) {
                    if(window.desktopLyric === null) {
                        let cmp = Qt.createComponent("./qcComponent/QCDesktopLyric.qml")
                        if(cmp.status === Component.Ready) {
                            window.desktopLyric = cmp.createObject()
                            window.desktopLyric.parentWindow = window

                            window.desktopLyric.lyricData = m_music_Player.thisMusicLyric
                            window.desktopLyric.mediaPlayer = m_music_Player
                            window.desktopLyric.show()

                        } else {
                            console.log("歌词加载失败！"+cmp.errorString())
                        }
                    } else if(window.desktopLyric.visible) {
                        window.desktopLyric.close()
                    } else {
                        window.desktopLyric.show()
                    }
                }
            }
            Component.onCompleted: {
                var w = 0
                for(var i = 0; i < children.length;i++) {
                    if(children[i] instanceof Text) {
                        w += children[i].contentWidth
                    } else w += children[i].width
                }
                width = w + children.length * spacing - spacing
            }
        }

        Row {
            width: parent.width*.3
            height: 35
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5
            Row {
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: cur
                    font.family: bottomBar.fontFamily
                    font.weight: 1
                    font.pointSize: bottomBar.fontSize
                    text: "00:00   "
                    color: "#572C27"
                    Component.onCompleted: {

                    }
                }
                Text {
                    id: dst
                    font.family: bottomBar.fontFamily
                    font.weight: 1
                    font.pointSize: bottomBar.fontSize
                    text: "/00:00"
                    color: "#572C27"
                }
            }

            QCVolumeBtn {

                propagateComposedEvents: true
                cursorShape: Qt.PointingHandCursor
                textColor: "#FFFF5966"
                backgroundColor: "#FF5966"
                sliderBackgroundColor: "#3F" + thisTheme.iconColor
                sliderColor: "#FFFF5966"
                handleBorderColor: "#FFFF5966"
                handleColor: "#FF5966"
                btnColor: "#00000000"
                btnHovredColor: "#1FFF5966"
                btnIconColor: "#FFFF5966"
            }

            // QCToolTipButton {
            //     width: 35
            //     height: width
            //     propagateComposedEvents: true
            //     cursorShape: Qt.PointingHandCursor
            //     iconSource: "qrc:/Images/playList.svg"
            //     hovredColor: "#1FFF5966"
            //     iconColor: "#FF5966"
            //     onClicked: function (mouse) {
            //         mouse.accepted = false
            //         if(p_qcThisPlayListLable.visible) {
            //             isHighlight = false
            //             p_qcThisPlayListLable.close()
            //         } else {
            //             isHighlight = true
            //             p_qcThisPlayListLable.startX = bottomBar.width
            //             p_qcThisPlayListLable.startY = bottomBar.y - p_qcThisPlayListLable.height
            //             p_qcThisPlayListLable.open()

            //         }
            //     }
            // }
            Component.onCompleted: {
                var w = 0
                for(var i = 0; i < children.length;i++) {
                    if(children[i] instanceof Text) {
                        w += children[i].contentWidth
                    } else w += children[i].width
                }
                width = w + children.length * spacing - spacing + 10
            }
        }

    }


