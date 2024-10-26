import 'dart:math';

import 'package:diacritic/diacritic.dart';

extension MapExt<K, V> on Map<K, V> {
  Iterable<(K, V)> toIterable() {
    return entries.map(
      (entry) => (entry.key, entry.value),
    );
  }
}

extension StringExt on String {
  String sanitize() {
    return removeDiacritics(this).toLowerCase();
  }
}

extension DoubleExt on double {
  double roundToPrecision(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}
