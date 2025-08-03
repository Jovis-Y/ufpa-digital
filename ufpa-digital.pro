QT += quick quickcontrols2 multimedia svg webview location positioning mqtt core5compat qmlxmllistmodel

CONFIG += c++17

DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        back/main.cpp \
        back/services/qmlmqttclient.cpp \
        back/services/utils.cpp

HEADERS += \
    back/services/qmlmqttclient.h \
    back/services/utils.h

android {
    SOURCES += back/android/android.cpp
    HEADERS += back/android/android.h

    ANDROID_PACKAGE_SOURCE_DIR = \
        $$PWD/back/android
    include($$PWD/android_openssl/openssl.pri)

    ANDROID_TARGET_SDK_VERSION = 21
    ANDROID_ABIS = armeabi-v7a arm64-v8a x86 x86_64
}

ios {
    QMAKE_INFO_PLIST = back/ios/Info.plist

    QMAKE_ASSET_CATALOGS = $$PWD/static/ios-icons/Images.xcassets
    QMAKE_ASSET_CATALOGS_APP_ICON = "AppIcon"
}

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =


QT_DEBUG_PLUGINS=1

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

unix:!android: TARGET = "UFPA Digital"
else: TARGET = "UFPADigital"

#Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    back/android/AndroidManifest.xml \
    back/android/build.gradle \
    back/android/gradle/wrapper/gradle-wrapper.jar \
    back/android/gradle/wrapper/gradle-wrapper.properties \
    back/android/gradlew \
    back/android/gradlew.bat \
    back/android/res/values/libs.xml \
    back/android/src/br/ufpa/ccsl/ufpadigital/AndroidManager.java \
    back/ios/Info.plist
