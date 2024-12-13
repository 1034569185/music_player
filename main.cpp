#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "framelesswindow.h"
#include <QtQml>
#include "musicplayer.h"
#include "iostream"
#include <QProcessEnvironment>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);


    // qmlRegisterType<FramelessWindow>("qc.window", 1, 0, "FramelessWindow");
    // qmlRegisterType<MusicPlayer>("qc.ms", 1, 0, "MusicPlayer");
    // REGISTER_QML_SINGLETON(MusicPlayer, new MusicPlayer());



    QQmlApplicationEngine engine;

    // QQmlContext *context = engine.rootContext();
    // context->setContextProperty("FramelessWindow", new FramelessWindow());

    const QUrl url(QStringLiteral("qrc:/music_player_demo/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
