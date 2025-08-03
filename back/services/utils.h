#ifndef UTILS_H
#define UTILS_H

#include <QObject>

class Utils : public QObject
{
    Q_OBJECT
public:
    explicit Utils(QObject *parent = nullptr);
    Q_INVOKABLE static bool openUrl(QString url, QString color="#0f3f68");

signals:

public slots:
};

#endif
