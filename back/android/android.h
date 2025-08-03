#ifndef ANDROID_H
#define ANDROID_H

#include <QObject>

class Android : public QObject
{
    Q_OBJECT
public:
    explicit Android(QObject *parent = nullptr);

    static void checkPermissions(QString permissions[]);
    static bool openCustomTab(QString url, QString color);

signals:

};

#endif // ANDROID_H
