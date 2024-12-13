/****************************************************************************
** Generated QML type registration code
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <QtQml/qqml.h>
#include <QtQml/qqmlmoduleregistration.h>

#if __has_include(<framelesswindow.h>)
#  include <framelesswindow.h>
#endif
#if __has_include(<musicplayer.h>)
#  include <musicplayer.h>
#endif
#if __has_include(<myutility.h>)
#  include <myutility.h>
#endif


#if !defined(QT_STATIC)
#define Q_QMLTYPE_EXPORT Q_DECL_EXPORT
#else
#define Q_QMLTYPE_EXPORT
#endif
Q_QMLTYPE_EXPORT void qml_register_types_music_player_demo()
{
    QT_WARNING_PUSH QT_WARNING_DISABLE_DEPRECATED
    qmlRegisterTypesAndRevisions<FramelessWindow>("music_player_demo", 1);
    qmlRegisterAnonymousType<QQuickWindow, 254>("music_player_demo", 1);
    qmlRegisterAnonymousType<QWindow, 254>("music_player_demo", 1);
    QMetaType::fromType<FramelessWindow::MousePosition>().id();
    qmlRegisterTypesAndRevisions<MusicPlayer>("music_player_demo", 1);
    qmlRegisterTypesAndRevisions<MyUtility>("music_player_demo", 1);
    QMetaType::fromType<QMediaPlayer *>().id();
    QMetaType::fromType<QMediaPlayer::PlaybackState>().id();
    QMetaType::fromType<QMediaPlayer::MediaStatus>().id();
    QMetaType::fromType<QMediaPlayer::Error>().id();
    QMetaType::fromType<QMediaPlayer::Loops>().id();
    QT_WARNING_POP
    qmlRegisterModule("music_player_demo", 1, 0);
}

static const QQmlModuleRegistration musicplayerdemoRegistration("music_player_demo", qml_register_types_music_player_demo);
