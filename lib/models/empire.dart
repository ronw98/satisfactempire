import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:satisfactempire/extensions.dart';
import 'package:satisfactempire/models/items.dart';

part 'empire.freezed.dart';
part 'empire.g.dart';

@freezed
class Empire with _$Empire {
  const Empire._();

  const factory Empire({
    required List<Planet> planets,
  }) = _Empire;

  factory Empire.fromJson(Map<String, dynamic> json) => _$EmpireFromJson(json);

  Map<SatisfactoryItem, double> get empireProduction {
    Map<SatisfactoryItem, double> totalProduction = {};

    for (final planet in planets) {
      final planetProduction = planet.planetProduction;
      for (final (item, rate) in planetProduction.toIterable()) {
        totalProduction.update(
          item,
          (value) => value + rate,
          ifAbsent: () => rate,
        );
      }
    }
    return totalProduction;
  }

  Map<SatisfactoryItem, ResourceSummary> get empireSummary {
    Map<SatisfactoryItem, ResourceSummary> totalSummary = {};
    for (final planet in planets) {
      final planetProduction = planet.planetSummary;
      for (final (item, summary) in planetProduction.toIterable()) {
        totalSummary.update(
          item,
          (existingSummary) => existingSummary + summary,
          ifAbsent: () => summary,
        );
      }
    }
    return totalSummary;
  }

  Map<String, List<ProductionLine>> itemConsumedIn(SatisfactoryItem item) {
    final result = <String, List<ProductionLine>>{};
    for (final planet in planets) {
      for (final productionLine in planet.productions) {
        if (productionLine.baseConsumption.containsKey(item)) {
          result.update(planet.id, (value) => value..add(productionLine), ifAbsent: () => [productionLine]);
        }
      }
    }
    return result;
  }

  Map<String, List<ProductionLine>> itemProducedIn(SatisfactoryItem item) {
    final result = <String, List<ProductionLine>>{};
    for (final planet in planets) {
      for (final productionLine in planet.productions) {
        if (productionLine.baseProduction.containsKey(item)) {
          result.update(planet.id, (value) => value..add(productionLine), ifAbsent: () => [productionLine]);
        }
      }
    }
    return result;
  }
}

@freezed
class Planet with _$Planet {
  const Planet._();

  const factory Planet({
    required String id,
    required String name,
    required SatisfactoryItem image,
    @Default('empire') String empireId,
    @Default([]) List<ProductionLine> productions,
  }) = _Planet;

  factory Planet.fromJson(Map<String, dynamic> json) => _$PlanetFromJson(json);

  /// Computes the entire production of the planet
  ///
  /// A negative entry value means the planet overall consumes the given item as
  /// a planetary input.
  /// A positive entry means the planet overall produces the given item as a
  /// planetary output.
  Map<SatisfactoryItem, double> get planetProduction {
    Map<SatisfactoryItem, double> totalProduction = {};
    for (final productionLine in productions.where((line) => line.exists)) {
      // Add all production of planet
      for (final (item, rate) in productionLine.baseProduction.toIterable()) {
        totalProduction.update(
          item,
          (value) => value + rate * productionLine.quantity,
          ifAbsent: () => rate * productionLine.quantity,
        );
      }
      // Subtract all consumption
      for (final (item, rate) in productionLine.baseConsumption.toIterable()) {
        totalProduction.update(
          item,
          (value) => value - rate * productionLine.quantity,
          ifAbsent: () => -rate * productionLine.quantity,
        );
      }
    }

    return totalProduction;
  }

  Map<SatisfactoryItem, ResourceSummary> get planetSummary {
    final Map<SatisfactoryItem, ResourceSummary> totalSummary = {};
    for (final productionLine in productions.where((line) => line.exists)) {
      // Add all production of planet
      for (final (item, rate) in productionLine.baseProduction.toIterable()) {
        totalSummary.update(
          item,
          (existingSummary) => existingSummary.copyWith(
            production:
                existingSummary.production + rate * productionLine.quantity,
          ),
          ifAbsent: () => ResourceSummary(
            production: rate * productionLine.quantity,
            consumption: 0,
          ),
        );
      }
      for (final (item, rate) in productionLine.baseConsumption.toIterable()) {
        totalSummary.update(
          item,
          (existingSummary) => existingSummary.copyWith(
            consumption:
                existingSummary.consumption + rate * productionLine.quantity,
          ),
          ifAbsent: () => ResourceSummary(
            consumption: rate * productionLine.quantity,
            production: 0,
          ),
        );
      }
    }
    return totalSummary;
  }
}

@freezed
class ProductionLine with _$ProductionLine {
  const factory ProductionLine({
    required String id,
    required String name,

    /// Production cost of producing the resource in a 100% rate machine
    required Map<SatisfactoryItem, double> baseConsumption,

    /// Production of the resource in a 100% rate machine
    required Map<SatisfactoryItem, double> baseProduction,

    /// Number of machines (.5 means a 50% machine)
    required double quantity,
    required SatisfactoryItem image,

    @Default(true)
    bool exists,
  }) = _ProductionLine;

  factory ProductionLine.fromJson(Map<String, dynamic> json) =>
      _$ProductionLineFromJson(json);
}

@freezed
class ResourceSummary with _$ResourceSummary {
  const ResourceSummary._();

  const factory ResourceSummary({
    required double production,
    required double consumption,
  }) = _ResourceSummary;

  ResourceSummary operator +(ResourceSummary other) {
    return ResourceSummary(
      production: production + other.production,
      consumption: consumption + other.consumption,
    );
  }

  double get differential => production - consumption;
}
