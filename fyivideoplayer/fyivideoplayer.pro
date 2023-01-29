TEMPLATE = app
TARGET = fyivideoplayer

QT += quick multimedia
android: qtHaveModule(androidextras) {
    QT += androidextras
    DEFINES += REQUEST_PERMISSIONS_ON_ANDROID
}

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        filepathmessenger.cpp \
        main.cpp

RESOURCES += qml.qrc

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
DISTFILES += \
    android/src/com/android/fyi/filepathmessenger/FilePathMessenger.java \
    android/AndroidManifest.xml

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



HEADERS += \
    filepathmessenger.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/drawable-xhdpi/icon.png \
    android/res/drawable-xxhdpi/icon.png \
    android/res/drawable-xxxhdpi/icon.png \
    android/src/com/android/fyi/filepathmessenger/FilePathMessenger.java
