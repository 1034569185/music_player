#include "myutility.h"

MyUtility::MyUtility(QObject *parent)
    : QObject{parent}
{}

QStringList MyUtility::showFiles(QString folder)
{
    QString str = folder.sliced(8).replace('/', "\\");
    qDebug() << str;
    QDir dir(str);
    QStringList res;

    if( dir.exists() )
    {
        res = dir.entryList(QDir::Files);
    }
    else
    {
        qDebug() << "There is no dir in giving path!!!";
    }

    return res;
}
