#ifndef MYUTILITY_H
#define MYUTILITY_H

#include <QObject>
#include <QQmlEngine>
#include <QFile>
#include <Qdir>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

class MyUtility : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MyUtility(QObject *parent = nullptr);
    Q_INVOKABLE QStringList showFiles(QString folder);
    Q_INVOKABLE QString getInit();
    Q_INVOKABLE void init(QString path);
    Q_INVOKABLE void download(QUrl url, QString file_name);

    QString downloadPath;
    QString targetFile;

    QString getDownloadPath() const;
    void setDownloadPath(const QString &newDownloadPath);

signals:
    void downloadPathChanged();

private slots:
    void onDownloadFinished();
    void onDataReady();


private:
    QNetworkAccessManager *net_manager;
    QNetworkReply *reply;
    QFile file;
    Q_PROPERTY(QString downloadPath READ getDownloadPath WRITE setDownloadPath NOTIFY downloadPathChanged FINAL)
};

#endif // MYUTILITY_H
