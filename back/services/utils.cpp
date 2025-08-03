#include "utils.h"

#include <QDesktopServices>
#include <QUrl>

#ifdef ANDROID
#include <back/android/android.h>
#endif

Utils::Utils(QObject *parent) : QObject(parent)
{
}

bool Utils::openUrl(QString url, QString color)
{
    bool success = false;

#ifdef ANDROID
    success = Android::openCustomTab(url, color);
#endif

    color = nullptr;
    return !success ? QDesktopServices::openUrl(QUrl(url)) : success;
}
