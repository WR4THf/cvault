#include <iostream>
#include <csignal>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "utils/KernelLogger/KernelLogger.h"



int main(int argc, char *argv[]){
    KernelLogger logger("CVault");
    static KernelLogger* glLogger = &logger;
    logger.info("Initializing CryptoVault");

    logger.info("Starting Qt");
    QGuiApplication app(argc, argv);
    std::signal(SIGINT, [](int signum) {
        glLogger->warn("SIGINT CRASH");
    });
    logger.info("Starting Qt/QML engine");
    QQmlApplicationEngine engine;

    logger.info("Starting GUI");
    return app.exec();
}