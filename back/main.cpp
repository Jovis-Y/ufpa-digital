#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebView>

#include <back/services/utils.h>
#include <back/services/qmlmqttclient.h>

#ifdef ANDROID
#include <back/android/android.h>
#endif

int main(int argc, char *argv[])
{
    QtWebView::initialize();

    QCoreApplication::setAttribute(Qt::AA_ShareOpenGLContexts);
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    //enable totem mode
    QStringList arguments;
    for (int i=0; i<argc; i++)
        arguments.push_front(argv[i]);

    if (arguments.contains("--totem"))
        qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);
    app.setOrganizationName("CCSL UFPA");
    app.setOrganizationDomain("ccsl.ufpa.br");
    app.setApplicationName("UFPA Digital");
    app.setApplicationVersion("vCurrent");

    qmlRegisterType<Utils>("Utils",1,0,"Utils");
    qmlRegisterType<QmlMqttClient>("MqttClient", 1, 0, "MqttClient");
    qmlRegisterUncreatableType<QmlMqttSubscription>("MqttClient", 1, 0, "MqttSubscription", QLatin1String("Subscriptions are read-only"));

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/front/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    // request permissions android
    #ifdef ANDROID
    QString permissions[] = {
        "android.permission.INTERNET",
        "android.permission.ACCESS_FINE_LOCATION",
        "android.permission.WRITE_EXTERNAL_STORAGE",
        "android.permission.READ_EXTERNAL_STORAGE"
    };
    Android::checkPermissions(permissions);
    #endif
    return app.exec();
}
