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
    QStringList filters;
    filters << "*.mp3";
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
