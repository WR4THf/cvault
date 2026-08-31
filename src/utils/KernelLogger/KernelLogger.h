#pragma once
#include <QString>
#include <QFile>

class KernelLogger {
public:
    explicit KernelLogger(const QString& prefix = "CVault");
    ~KernelLogger();

    void info(const QString& message);
    void error(const QString& message);
    void warn(const QString& message);
private:
    static constexpr const char* ERR = "<3>";
    static constexpr const char* WARN = "<4>";
    static constexpr const char* INFO = "<6>";

    QString m_prefix;
    QFile m_kmsgFile;
    void writeLog(const char* level, const QString& message);
};