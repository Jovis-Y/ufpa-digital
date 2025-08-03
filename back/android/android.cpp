#include "android.h"
#include <QtAndroid>

Android::Android(QObject *parent) : QObject(parent)
{

}

void Android::checkPermissions(QString permissions[]) {
    QStringList deniedsPermissions;

    for (QString permission : *permissions) {
        auto  result = QtAndroid::checkPermission(QString(permission));
        if (result == QtAndroid::PermissionResult::Denied)
            deniedsPermissions.append(permission);
    }
    if (!deniedsPermissions.empty()){
        QtAndroid::requestPermissionsSync(deniedsPermissions);
    }
}

bool Android::openCustomTab(QString url, QString color) {
    QAndroidJniObject javaStringUrl = QAndroidJniObject::fromString(url);
    QAndroidJniObject javaStringColor = QAndroidJniObject::fromString(color);

    bool flag = QAndroidJniObject::callStaticMethod<jboolean>(
                  "br/ufpa/ccsl/ufpadigital/AndroidManager"
                , "openCustomTab"
                , "(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)Z"
                , QtAndroid::androidContext().object()
                , javaStringUrl.object()
                , javaStringColor.object()
                );
    return flag;
}
