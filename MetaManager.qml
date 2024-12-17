import QtQuick

Item {
    property var arr
    property var prefix
    property var cur
    property var end

    function preMusicPlay() {
        cur = (cur - 1 + end) % end
        m_music_Player.m_setSource(prefix.concat('/', arr[cur]))
        m_music_Player.m_play()
    }

    function nextMusicPlay() {
        cur = (cur + 1) % end
        m_music_Player.m_setSource(prefix.concat('/', arr[cur]))
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
