// clang-format off
// upload_speed 921600
// board featheresp32

#ifndef _FEATHERESP32_H
#define _FEATHERESP32_H
#include <stdint.h>

// Adafruit ESP32 Feather + the LoRaWAN Wing
// NOTE: if LORA_IRQ and LORA_IO1 are tied to the same GPIO using diodes on the board, 
// you must disable LMIC_USE_INTERRUPTS in lmic_config.h

// disable brownout detection (avoid unexpected reset on some boards)
#define DISABLE_BROWNOUT 1 // comment out if you want to keep brownout feature

#define HAS_LORA 1       // comment out if device shall not send data via LoRa


#define CFG_sx1276_radio 1 // RFM95 module

// Pins for LORA chip SPI interface, reset line and interrupt lines
#define LORA_SCK  5  // SCK --ok
#define LORA_CS   14 // 14 ---ok
#define LORA_MISO 19 // MI ---ok
#define LORA_MOSI 18 // MO ---pk
#define LORA_RST  32 // LMIC_UNUSED_PIN
#define LORA_IRQ  33 // 33
#define LORA_IO1  15 // 33
#define LORA_IO2  LMIC_UNUSED_PIN // LMIC_UNUSED_PIN

#endif
