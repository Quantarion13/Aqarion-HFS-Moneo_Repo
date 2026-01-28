#include <WiFi.h>
#include <Adafruit_NeoPixel.h>
#include <MIDI.h>
#include <driver/adc.h>

// ─── CONFIG ──────────────────────────────────────────────────────────────
#define LED_PIN     4
#define LASER_PIN   5
#define PIEZO_PIN   34
#define NUM_LEDS    64
#define PHI_43      22.93606797749979

Adafruit_NeoPixel pixels(NUM_LEDS, LED_PIN, NEO_GRB + NEO_KHZ800);
MIDI_CREATE_DEFAULT_INSTANCE();

// ─── GLOBALS ─────────────────────────────────────────────────────────────
float piezo_baseline = 0;
float last_fft_mag[8] = {0};

void setup() {
  Serial.begin(115200);
  pixels.begin();
  pixels.clear();
  pixels.show();

  pinMode(LASER_PIN, OUTPUT);
  analogReadResolution(12);
  adc1_config_width(ADC_WIDTH_BIT_12);
  adc1_config_channel_atten(ADC1_CHANNEL_6, ADC_ATTEN_DB_11);  // GPIO34

  MIDI.begin(MIDI_CHANNEL_OMNI);
  MIDI.turnThruOn();

  // WiFi for federation logging (silent)
  WiFi.begin("SSID", "PASS");  // change

  calibrate_piezo();
}

void loop() {
  // 1. Read piezo + laser feedback
  int raw = adc1_get_raw(ADC1_CHANNEL_6);
  float piezo = raw - piezo_baseline;

  // 2. Simple FFT emulation (sliding window)
  static float window[32];
  static int idx = 0;
  window[idx++] = piezo;
  idx %= 32;

  // Rough magnitude estimate
  float mag = 0;
  for (int i = 0; i < 32; i++) mag += abs(window[i]);
  mag /= 32;

  // 3. SNN-like inference (toy model)
  float inference = mag * PHI_43 * 0.01;  // scale to 0-1 range

  // 4. Actuate
  int brightness = constrain(inference * 255, 0, 255);
  pixels.fill(pixels.Color(brightness, 0, brightness / 2));
  pixels.show();

  analogWrite(LASER_PIN, brightness);  // PWM laser intensity

  // 5. MIDI CC feedback
  MIDI.sendControlChange(1, brightness / 2, 1);  // CC1 = modulation

  delay(20);  // ~50 Hz loop
}

void calibrate_piezo() {
  long sum = 0;
  for (int i = 0; i < 100; i++) {
    sum += adc1_get_raw(ADC1_CHANNEL_6);
    delay(10);
  }
  piezo_baseline = sum / 100.0;
  Serial.printf("Piezo baseline: %.1f\n", piezo_baseline);
}
