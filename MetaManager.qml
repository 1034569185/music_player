import QtQuick

Item {
    Connections {
        target: m_music_Player
        function onMetaDataChanged() {
            print( m_music_Player.getMetaData() )
            print("triggerd")
            // print( m_music_Player.name() )
            // print(m_music_Player.artist())
            // print(m_music_Player.duration())
            // print(m_music_Player.coverImage())
        }
    }
}
