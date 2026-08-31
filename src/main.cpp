#include <iostream>
#include "utils/KernelLogger/KernelLogger.h"

int main(){
    KernelLogger logger("CVault");
    logger.info("Initializing CryptoVault");
    return 0;
}