#include "musicplayer.h"

MusicPlayer::MusicPlayer(QMediaPlayer *parent)
    :QMediaPlayer{parent},
    audioOutput(new QAudioOutput(this)),
    isPaused(true)

{
    this->audioOutput->setVolume(0.35);
    this->setAudioOutput(this->audioOutput);
}

void MusicPlayer::m_play()
{
    //this->setSource(QUrl::fromLocalFile("F:\\CloudMusic\\君の美術館 - プレインエイジア.mp3"));
    // this->setSource(QUrl::fromLocalFile(R"(F:\CloudMusic\numb_high.mp3)"));

    this->play();
    // QMediaMetaData meta = this->metaData();
    // // qDebug()  << meta.keys() << Qt::endl;
    // for( auto k : meta.keys() )
    //     qDebug() << k << ": -->"  << meta[k] << Qt::endl;;

    setIsPaused(false);
}

void MusicPlayer::m_pause()
{
    this->pause();
    setIsPaused(true);
}

void MusicPlayer::m_stop()
{
    this->stop();
    setIsPaused(true);
}

void MusicPlayer::m_setSource(const QUrl &source)
{
    qDebug() << source << Qt::endl;
    this->setSource(source);
    QTimer::singleShot(70, this, &MusicPlayer::onInitializationDone);

}

QMediaMetaData MusicPlayer::getMetaData()
{
    QMediaMetaData e = this->metaData();

    QList<QMediaMetaData::Key> keys = e.keys();
    for( QMediaMetaData::Key k : keys )
        qDebug() << e[k];
    // qDebug() <<

    return this->metaData();
}


bool MusicPlayer::getIsPaused() const
{
    return isPaused;
}

void MusicPlayer::setIsPaused(bool newIsPaused)
{
    if (isPaused == newIsPaused)
        return;
    isPaused = newIsPaused;
    emit isPausedChanged();
}


QString MusicPlayer::name() const
{
    return this->metaData().value(QMediaMetaData::Title).toString();
}

QString MusicPlayer::artist() const
{
    return this->metaData().value(QMediaMetaData::ContributingArtist).toString();
}

qint64 MusicPlayer::duration() const
{
    return this->metaData().value(QMediaMetaData::Duration).toLongLong();
}

QString  MusicPlayer::coverImage() const
{
    QImage image = this->metaData().value(QMediaMetaData::ThumbnailImage).value<QImage>();
    QByteArray byteArray;
    QBuffer buffer(&byteArray);
    buffer.open(QIODevice::WriteOnly);
    image.save(&buffer, "PNG"); // 或者其他格式

    return QString(byteArray.toBase64());
}


