#ifndef MYUTILITY_H
#define MYUTILITY_H

#include <QObject>
#include <QQmlEngine>
#include <QFile>
#include <Qdir>

class MyUtility : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MyUtility(QObject *parent = nullptr);
    Q_INVOKABLE QStringList showFiles(QString folder);
    Q_INVOKABLE QString getInit();
    Q_INVOKABLE void init(QString path);

signals:
};

#endif // MYUTILITY_H
