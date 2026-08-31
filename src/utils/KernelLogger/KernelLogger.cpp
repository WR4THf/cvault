#include "KernelLogger.h"
#include <QDebug>

KernelLogger::KernelLogger(const QString& prefix) 
    : m_prefix(prefix)
{
    m_kmsgFile.setFileName("/dev/kmsg");
    if (!m_kmsgFile.open(QIODevice::WriteOnly | QIODevice::Unbuffered)) {

        qWarning() << "[!] Cvault must be run as root";
    }
}

KernelLogger::~KernelLogger() {
    if (m_kmsgFile.isOpen()) {
        m_kmsgFile.close();
    }
}


void KernelLogger::writeLog(const char* level, const QString& message) {
    if (m_kmsgFile.isOpen()) {
        QByteArray logEntry = QString("%1%2: %3\n").arg(level, m_prefix, message).toUtf8();
        m_kmsgFile.write(logEntry);
    } else {
        qDebug().noquote() << m_prefix << ":" << message;
    }
}

void KernelLogger::info(const QString& message) {
    writeLog(INFO, message);
}

void KernelLogger::error(const QString& message) {
    writeLog(ERR, message);
}
void KernelLogger::warn(const QString& message) {
    writeLog(WARN, message);
}