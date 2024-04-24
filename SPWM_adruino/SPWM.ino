

// Define pins
const int spwmPin = 9;       // SPWM output pin
const int inverseSpwmPin = 10; // Inverse SPWM output pin

// Timing
unsigned long lastCarrierUpdate = 0;
const int carrierPeriod = 10000 / 1001; // Carrier period in microseconds for 1001 Hz

// Sine wave parameters
const float sineFrequency = 100.0; // Fundamental frequency in Hz
const int sinePoints = 200;        // Number of points in one sine wave period
float sineWave[sinePoints];       // Sine wave lookup table

void setup() {
  pinMode(spwmPin, OUTPUT);
  pinMode(inverseSpwmPin, OUTPUT);

  // Generate sine wave lookup table
  for (int i = 0; i < sinePoints; i++) {
    sineWave[i] = (sin(2 * PI * i / sinePoints) + 1) / 2; // Normalize to 0-1
  }
}

void loop() {
  static int index = 0;
  unsigned long currentTime = micros();

  // Update SPWM at carrier frequency rate
  if (currentTime - lastCarrierUpdate >= carrierPeriod) {
    lastCarrierUpdate = currentTime;

    // Calculate duty cycle for current sine wave position
    float dutyCycle = sineWave[index];

    // Update PWM duty cycle
    analogWrite(spwmPin, dutyCycle * 255); // Scale to 0-255
    analogWrite(inverseSpwmPin, (1 - dutyCycle) * 255); // Inverse

    // Move to the next point in sine wave
    index = (index + 1) % sinePoints;
  }
}
