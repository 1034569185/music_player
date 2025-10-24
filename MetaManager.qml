import QtQuick

Item {
    property var arr
    property var prefix
    property var cur
    property var end
    property var mode

    function preMusicPlay() {
        cur = (cur - 1 + end) % end
        if( mode == "offline"){
            m_music_Player.m_setSource(prefix.concat('/', arr[cur]))
        }
        else{
            let temp = JSON.stringify(arr[cur])
            let mp = JSON.parse(temp)
            m_music_Player.m_setSource(mp["url"])
        }
        m_music_Player.m_play()
    }

    function nextMusicPlay() {
        cur = (cur + 1) % end
        if( mode == "offline"){
            m_music_Player.m_setSource(prefix.concat('/', arr[cur]))
        }else{
            let temp = JSON.stringify(arr[cur])
            let mp = JSON.parse(temp)
            m_music_Player.m_setSource(mp["url"])
        }
        m_music_Player.m_play()
    }

    Connections {
        target: m_music_Player
        function onMediaStatusChanged() {
            if(m_music_Player.mediaStatus === 6)
            {
                nextMusicPlay()
            }
        }
    }
}
