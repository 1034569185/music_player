#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H

#include <QObject>
#include <QQmlEngine>
#include <QMediaPlayer>
#include <QAudioOutput>
#include <QMediaMetaData>
#include <QDebug>
#include <QImage>
#include <QByteArray>
#include <QBuffer>
#include <QTimer>
// #include "qml_singleton.h"

class MusicPlayer : public QMediaPlayer
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MusicPlayer(QMediaPlayer *parent = nullptr);
    Q_INVOKABLE void m_play();
    Q_INVOKABLE void m_pause();
    Q_INVOKABLE void m_stop();
    Q_INVOKABLE void m_setSource(const QUrl &source);
    Q_INVOKABLE QMediaMetaData getMetaData();

    bool isPaused;
    float lastVolume;


    bool getIsPaused() const;
    void setIsPaused(bool newIsPaused);

    QString name() const;

    QString artist() const;

    QString coverImage() const;

    qint64 duration() const;


    float volume() const;
    void setVolume(float newVolume);

    float getLastVolume() const;
    void setLastVolume(float newLastVolume);

signals:

    void isPausedChanged();


    void metaDataChanged();

    void volumeChanged();

    void lastVolumeChanged();

private:
    QAudioOutput *audioOutput;
    Q_PROPERTY(bool isPaused READ getIsPaused WRITE setIsPaused NOTIFY isPausedChanged FINAL)
    Q_PROPERTY(QString name READ name NOTIFY metaDataChanged)
    Q_PROPERTY(QString artist READ artist NOTIFY metaDataChanged)
    Q_PROPERTY(qint64  duration READ duration NOTIFY metaDataChanged)
    Q_PROPERTY(QString coverImage READ coverImage NOTIFY metaDataChanged)

    Q_PROPERTY(float volume READ volume WRITE setVolume NOTIFY volumeChanged FINAL)

    Q_PROPERTY(float lastVolume READ getLastVolume WRITE setLastVolume NOTIFY lastVolumeChanged FINAL)

public  slots:
    void onInitializationDone(){emit metaDataChanged();}
};

// DECLARE_QML_SINGLETON(MusicPlayer)

#endif // MUSICPLAYER_H
