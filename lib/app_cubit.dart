import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:satisfactempire/models/empire.dart';
import 'package:satisfactempire/view/new_planet_dialog.dart';
import 'package:uuid/uuid.dart';

part 'app_cubit.freezed.dart';

@freezed
sealed class AppCubitState with _$AppCubitState {
  const factory AppCubitState.loaded({
    required Empire empire,
  }) = AppLoaded;

  const factory AppCubitState.loading() = AppLoading;

  const factory AppCubitState.error({dynamic error}) = AppError;

  const factory AppCubitState.initial() = AppInitial;
}

class AppCubit extends Cubit<AppCubitState> {
  AppCubit() : super(AppCubitState.initial()) {
    init();
  }

  late final StreamSubscription _planetsSubscription;

  void init() {
    _planetsSubscription = FirebaseFirestore.instance
        .collection('planets')
        .where('empireId', isEqualTo: 'empire')
        .snapshots()
        .map(
      (snapshot) {
        return snapshot.docs.map((doc) => Planet.fromJson(doc.data())).toList();
      },
    ).listen(
      (planets) => emit(AppCubitState.loaded(empire: Empire(planets: planets))),
      onError: (e) {
        emit(AppCubitState.error(error: e));
      },
      cancelOnError: false,
    );
  }

  void createPlanet(PlanetCreationResult data) {
    final id = Uuid().v4();
    FirebaseFirestore.instance.collection('planets').doc(id).set(
          Planet(id: id, name: data.name, image: data.image).toJson(),
        );
  }

  @override
  Future<void> close() async {
    await _planetsSubscription.cancel();
    return super.close();
  }

  void deletePlanet(Planet planet) {
    FirebaseFirestore.instance.collection('planets').doc(planet.id).delete();
  }

  void updatePlanetLine(String planetId, ProductionLine editedLine) {
    if (state case AppLoaded(empire: final empire)) {
      final planet = empire.planets.firstWhereOrNull((p) => p.id == planetId);
      if (planet == null) return;
      final lineIndex =
          planet.productions.indexWhere((l) => l.id == editedLine.id);
      final updatedLines = [...planet.productions]..[lineIndex] = editedLine;

      final updatedPlanet = planet.copyWith(productions: updatedLines);
      FirebaseFirestore.instance.collection('planets').doc(planetId).set(
            updatedPlanet.toJson(),
          );
    }
  }

  void addProductionLine(String planetId, ProductionLine newProduction) {
    if (state case AppLoaded(empire: final empire)) {
      final planet = empire.planets.firstWhereOrNull((p) => p.id == planetId);
      if (planet == null) return;
      final updatedLines = [...planet.productions, newProduction];

      final updatedPlanet = planet.copyWith(productions: updatedLines);
      FirebaseFirestore.instance.collection('planets').doc(planetId).set(
            updatedPlanet.toJson(),
          );
    }
  }

  void deleteProductionLine(String planetId, ProductionLine line) {
    if (state case AppLoaded(empire: final empire)) {
      final planet = empire.planets.firstWhereOrNull((p) => p.id == planetId);
      if (planet == null) return;
      final updatedLines =
          planet.productions.where((l) => l.id != line.id).toList();

      final updatedPlanet = planet.copyWith(productions: updatedLines);
      FirebaseFirestore.instance.collection('planets').doc(planetId).set(
            updatedPlanet.toJson(),
          );
    }
  }
}
