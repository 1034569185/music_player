#include "myutility.h"

MyUtility::MyUtility(QObject *parent)
    : QObject{parent},
    net_manager{new QNetworkAccessManager(this)}
{}

QStringList MyUtility::showFiles(QString folder)
{
    QString str = folder.sliced(8).replace('/', "\\");
    qDebug() << str;
    QDir dir(str);
    QStringList res;
    QStringList filters;
    filters << "*.mp3" << "*.flac";
    if( dir.exists() )
    {
        res = dir.entryList(filters, QDir::Files);
    }
    else
    {
        qDebug() << "There is no dir in giving path!!!";
    }

    return res;
}

QString MyUtility::getInit()
{
    QFile file("backup");
    QString res;
    if(  file.open(QFile::ReadOnly) )
    {
        QTextStream in(&file);
        res = in.readLine();
    }
    else
        res = "";

    file.close();
    return res;
}

void MyUtility::init(QString path)
{
    QFile file("backup");
    if(  file.open(QFile::WriteOnly) )
    {
        QTextStream out(&file);
        out << path;
    }

    file.close();
}

void MyUtility::download(QUrl url, QString file_name)
{
    QNetworkRequest request(url);
    reply = net_manager->get(request);
    qDebug() << downloadPath;
    targetFile = downloadPath.sliced(8).append('/').append(file_name).append(".flac");


    // 连接信号槽
    connect(reply, &QNetworkReply::finished, this, &MyUtility::onDownloadFinished);
    connect(reply, &QNetworkReply::readyRead, this, &MyUtility::onDataReady);
}

void MyUtility::onDownloadFinished()
{
    // 检查下载是否成功
    if (reply->error() == QNetworkReply::NoError) {
        qDebug() << "Download finished successfully.";
        file.close();
    } else {
        qDebug() << "Error occurred: " << reply->errorString();
    }

    // 释放资源
    reply->deleteLater();
    // net_manager->deleteLater();
}

void MyUtility::onDataReady()
{
    // 将接收到的数据写入文件
    QByteArray data = reply->readAll();
    if (!file.isOpen()) {
        file.setFileName(targetFile);
        if (!file.open(QIODevice::WriteOnly)) {
            qDebug() << "Failed to open file for writing.";
            return;
        }
    }
    file.write(data);
}

QString MyUtility::getDownloadPath() const
{
    return downloadPath;
}

void MyUtility::setDownloadPath(const QString &newDownloadPath)
{
    if (downloadPath == newDownloadPath)
        return;
    downloadPath = newDownloadPath;
    emit downloadPathChanged();
}
