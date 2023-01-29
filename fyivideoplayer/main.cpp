#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQuick/QQuickView>
#include <QScreen>
#include <QQmlContext>
#include "filepathmessenger.h"

#ifdef REQUEST_PERMISSIONS_ON_ANDROID
#include <QtAndroid>

bool requestStoragePermission() {
    using namespace QtAndroid;

    QString permission = QStringLiteral("android.permission.WRITE_EXTERNAL_STORAGE");
    const QHash<QString, PermissionResult> results = requestPermissionsSync(QStringList({permission}));
    if (!results.contains(permission) || results[permission] == PermissionResult::Denied) {
        qWarning() << "Couldn't get permission: " << permission;
        return false;
    }

    return true;
}
#endif

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

#ifdef REQUEST_PERMISSIONS_ON_ANDROID
    if (!requestStoragePermission())
        return -1;
#endif

    QQuickView viewer;
    FilePathMessenger *filePathMessenger = new FilePathMessenger(&app);

    viewer.rootContext()->setContextProperty("FilePathMessenger", filePathMessenger);

    viewer.setSource(QUrl("qrc:/main.qml"));

    QObject::connect(viewer.engine(), &QQmlEngine::quit, &viewer, &QQuickView::close);

    QScreen *screen = app.primaryScreen();
    QRect geometry = screen->geometry();
    viewer.setMinimumSize(QSize(geometry.height(), geometry.width()));
    viewer.show();

    return app.exec();
}
