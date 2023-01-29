#ifndef FILEPATHMESSENGER_H
#define FILEPATHMESSENGER_H

#include <QObject>

class FilePathMessenger: public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString videoUrl READ selectedFile NOTIFY videoUrlSelected)

public:
    explicit FilePathMessenger(QObject *parent = nullptr);
    static FilePathMessenger *instance() { return m_instance; }
    Q_INVOKABLE void pickVideoFile();

    const QString &selectedFile() const;
    void setSelectedFile(const QString &newSelectedFile);

signals:
    void messageFromJava(const QString &message);
    void videoUrlSelected();

public slots:

private:
    static FilePathMessenger *m_instance;
    QString m_selectedFile;
};


#endif // FILEPATHMESSENGER_H
