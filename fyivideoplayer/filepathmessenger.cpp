#include "filepathmessenger.h"

#include <QAndroidJniObject>
#include <QAndroidJniEnvironment>
#include <QtAndroid>
#include <QDebug>

FilePathMessenger *FilePathMessenger::m_instance = nullptr;

#ifdef __cplusplus
extern "C" {
#endif

JNIEXPORT void JNICALL
Java_com_android_fyi_filepathmessenger_FilePathMessenger_fileSelected(JNIEnv */*env*/,
                                                             jobject /*obj*/,
                                                             jstring results)
{
    emit FilePathMessenger::instance()->messageFromJava(QAndroidJniObject(results).toString());
}

#ifdef __cplusplus
}
#endif


FilePathMessenger::FilePathMessenger(QObject *parent) : QObject(parent), m_selectedFile("")
{
    m_instance = this;

    connect(m_instance, &FilePathMessenger::messageFromJava, m_instance, &FilePathMessenger::setSelectedFile);
}

void FilePathMessenger::pickVideoFile()
{
    QAndroidJniObject::callStaticMethod<void>("com/android/fyi/filepathmessenger/FilePathMessenger",
                                       "selectVideo",
                                              "()V");
}

const QString &FilePathMessenger::selectedFile() const
{
    return m_selectedFile;
}

void FilePathMessenger::setSelectedFile(const QString &newSelectedFile)
{
    m_selectedFile = newSelectedFile;
    emit videoUrlSelected();
}

