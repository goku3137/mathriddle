import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

void main() {
  final outputDir = Directory('assets/sounds');
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  const sampleRate = 44100;

  // 1. tap.wav: Clean, subtle 35ms tactile click
  _generateSound(
    file: File('assets/sounds/tap.wav'),
    durationSec: 0.035,
    sampleRate: sampleRate,
    generator: (t) {
      final env = math.exp(-t * 110);
      final s = math.sin(2 * math.pi * 780 * t) * 0.8 +
          math.sin(2 * math.pi * 1560 * t) * 0.2;
      return s * env * 0.45;
    },
  );

  // 2. correct.wav: Uplifting, crystal-clear 2-tone chime (E5 -> A5)
  _generateSound(
    file: File('assets/sounds/correct.wav'),
    durationSec: 0.32,
    sampleRate: sampleRate,
    generator: (t) {
      double s = 0.0;
      if (t < 0.14) {
        final env = math.min(t / 0.015, 1.0) * math.exp(-t * 12);
        s = math.sin(2 * math.pi * 659.25 * t) * env;
      }
      if (t >= 0.10) {
        final t2 = t - 0.10;
        final env2 = math.min(t2 / 0.015, 1.0) * math.exp(-t2 * 10);
        s += (math.sin(2 * math.pi * 880.0 * t2) * 0.75 +
                math.sin(2 * math.pi * 1760.0 * t2) * 0.25) *
            env2;
      }
      return s * 0.55;
    },
  );

  // 3. incorrect.wav: Gentle low-frequency muted pulse (180Hz -> 130Hz)
  _generateSound(
    file: File('assets/sounds/incorrect.wav'),
    durationSec: 0.22,
    sampleRate: sampleRate,
    generator: (t) {
      final freq = 180.0 - (50.0 * (t / 0.22));
      final env = math.min(t / 0.015, 1.0) * math.exp(-t * 16);
      final s = math.sin(2 * math.pi * freq * t) * 0.85 +
          math.sin(2 * math.pi * freq * 2 * t) * 0.15;
      return s * env * 0.50;
    },
  );

  // 4. level_complete.wav: Resonant, triumphant major arpeggio flourish (C5 -> E5 -> G5 -> C6)
  _generateSound(
    file: File('assets/sounds/level_complete.wav'),
    durationSec: 0.65,
    sampleRate: sampleRate,
    generator: (t) {
      double s = 0.0;
      const notes = [
        (time: 0.00, freq: 523.25), // C5
        (time: 0.09, freq: 659.25), // E5
        (time: 0.18, freq: 783.99), // G5
        (time: 0.27, freq: 1046.50), // C6
        (time: 0.27, freq: 1318.51), // E6 harmony
      ];

      for (final note in notes) {
        if (t >= note.time) {
          final localT = t - note.time;
          final env = math.min(localT / 0.02, 1.0) * math.exp(-localT * 7.5);
          s += math.sin(2 * math.pi * note.freq * localT) * env * 0.35;
        }
      }
      return s * 0.65;
    },
  );

  // 5. heart_lost.wav: Soft, descending teardrop tone (440Hz -> 349Hz)
  _generateSound(
    file: File('assets/sounds/heart_lost.wav'),
    durationSec: 0.30,
    sampleRate: sampleRate,
    generator: (t) {
      double s = 0.0;
      if (t < 0.15) {
        final env = math.min(t / 0.015, 1.0) * math.exp(-t * 14);
        s = math.sin(2 * math.pi * 440.0 * t) * env * 0.6;
      }
      if (t >= 0.11) {
        final t2 = t - 0.11;
        final env2 = math.min(t2 / 0.015, 1.0) * math.exp(-t2 * 12);
        s += math.sin(2 * math.pi * 349.23 * t2) * env2 * 0.6;
      }
      return s * 0.45;
    },
  );

  // 6. reward.wav: Sparkling arpeggio chime (G5 -> B5 -> D6 -> G6)
  _generateSound(
    file: File('assets/sounds/reward.wav'),
    durationSec: 0.38,
    sampleRate: sampleRate,
    generator: (t) {
      double s = 0.0;
      const notes = [
        (time: 0.00, freq: 783.99), // G5
        (time: 0.07, freq: 987.77), // B5
        (time: 0.14, freq: 1174.66), // D6
        (time: 0.21, freq: 1567.98), // G6
      ];

      for (final note in notes) {
        if (t >= note.time) {
          final localT = t - note.time;
          final env = math.min(localT / 0.015, 1.0) * math.exp(-localT * 11);
          s += (math.sin(2 * math.pi * note.freq * localT) * 0.8 +
                  math.sin(2 * math.pi * note.freq * 2 * localT) * 0.2) *
              env *
              0.38;
        }
      }
      return s * 0.60;
    },
  );

  // 7. challenge_start.wav: Crisp ascending double chime
  _generateSound(
    file: File('assets/sounds/challenge_start.wav'),
    durationSec: 0.38,
    sampleRate: sampleRate,
    generator: (t) {
      double s = 0.0;
      if (t < 0.16) {
        final env = math.min(t / 0.015, 1.0) * math.exp(-t * 11);
        s = math.sin(2 * math.pi * 587.33 * t) * env * 0.6;
      }
      if (t >= 0.12) {
        final t2 = t - 0.12;
        final env2 = math.min(t2 / 0.015, 1.0) * math.exp(-t2 * 9);
        s += math.sin(2 * math.pi * 880.0 * t2) * env2 * 0.7;
      }
      return s * 0.55;
    },
  );

  // 8. challenge_end.wav: Calming resolution chime
  _generateSound(
    file: File('assets/sounds/challenge_end.wav'),
    durationSec: 0.42,
    sampleRate: sampleRate,
    generator: (t) {
      double s = 0.0;
      if (t < 0.18) {
        final env = math.min(t / 0.02, 1.0) * math.exp(-t * 9);
        s = math.sin(2 * math.pi * 659.25 * t) * env * 0.55;
      }
      if (t >= 0.14) {
        final t2 = t - 0.14;
        final env2 = math.min(t2 / 0.02, 1.0) * math.exp(-t2 * 7.5);
        s += math.sin(2 * math.pi * 523.25 * t2) * env2 * 0.65;
      }
      return s * 0.50;
    },
  );

  // 9. hint_unlocked.wav: Illuminating sparkle triad
  _generateSound(
    file: File('assets/sounds/hint_unlocked.wav'),
    durationSec: 0.35,
    sampleRate: sampleRate,
    generator: (t) {
      final env = math.min(t / 0.02, 1.0) * math.exp(-t * 10);
      final s = math.sin(2 * math.pi * 1046.50 * t) * 0.4 +
          math.sin(2 * math.pi * 1318.51 * t) * 0.35 +
          math.sin(2 * math.pi * 1567.98 * t) * 0.25;
      return s * env * 0.55;
    },
  );

  stdout.writeln('Successfully generated all 9 sound assets in assets/sounds/');
}

void _generateSound({
  required File file,
  required double durationSec,
  required int sampleRate,
  required double Function(double t) generator,
}) {
  final numSamples = (durationSec * sampleRate).toInt();
  final dataSize = numSamples * 2;
  final fileSize = 36 + dataSize;

  final bytes = BytesBuilder();

  // WAV Header (44 bytes)
  final header = ByteData(44);
  header.setUint8(0, 0x52); // 'R'
  header.setUint8(1, 0x49); // 'I'
  header.setUint8(2, 0x46); // 'F'
  header.setUint8(3, 0x46); // 'F'
  header.setUint32(4, fileSize, Endian.little);
  header.setUint8(8, 0x57); // 'W'
  header.setUint8(9, 0x41); // 'A'
  header.setUint8(10, 0x56); // 'V'
  header.setUint8(11, 0x45); // 'E'
  header.setUint8(12, 0x66); // 'f'
  header.setUint8(13, 0x6D); // 'm'
  header.setUint8(14, 0x74); // 't'
  header.setUint8(15, 0x20); // ' '
  header.setUint32(16, 16, Endian.little); // PCM subchunk size
  header.setUint16(20, 1, Endian.little); // Linear PCM
  header.setUint16(22, 1, Endian.little); // Mono
  header.setUint32(24, sampleRate, Endian.little);
  header.setUint32(28, sampleRate * 2, Endian.little); // Byte rate
  header.setUint16(32, 2, Endian.little); // Block align
  header.setUint16(34, 16, Endian.little); // 16-bit
  header.setUint8(36, 0x64); // 'd'
  header.setUint8(37, 0x61); // 'a'
  header.setUint8(38, 0x74); // 't'
  header.setUint8(39, 0x61); // 'a'
  header.setUint32(40, dataSize, Endian.little);

  bytes.add(header.buffer.asUint8List());

  final sampleBuffer = ByteData(2);
  for (int i = 0; i < numSamples; i++) {
    final t = i / sampleRate;
    final val = generator(t).clamp(-1.0, 1.0);
    final pcm16 = (val * 32767.0).toInt().clamp(-32768, 32767);
    sampleBuffer.setInt16(0, pcm16, Endian.little);
    bytes.add(sampleBuffer.buffer.asUint8List());
  }

  file.writeAsBytesSync(bytes.toBytes(), flush: true);
}

