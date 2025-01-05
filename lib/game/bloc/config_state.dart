part of 'config_bloc.dart';


final class ConfigModel {
  final int grid;
  final double cellSize;
  final double speed;
  final bool paused;

  const ConfigModel({
    required this.grid,
    required this.cellSize,
    required this.speed,
    this.paused = false,
  });


  ConfigModel copyWith({
    int? grid,
    double? cellSize,
    double? speed,
    bool? paused,
  }) {
    return ConfigModel(
      grid: grid ?? this.grid,
      cellSize: cellSize ?? this.cellSize,
      speed: speed ?? this.speed,
      paused: paused ?? this.paused,
    );
  }

}

final class ConfigState {

  final ConfigModel model;
  final ConfigEventState state;

  const ConfigState({
      required this.model,
      required this.state
  });

  ConfigState.initial() : this(
    model: ConfigModel(
      grid: Configs.grid,
      cellSize: Configs.cellSize,
      speed: Configs.speed,
    ),
    state: ConfigInitial(),
  );

  ConfigState copyWith({
    ConfigModel? model,
    ConfigEventState? state,
  }) {
    return ConfigState(
      model: model ?? this.model,
      state: state ?? this.state,
    );
  }

}

@immutable
sealed class ConfigEventState {}

final class ConfigInitial extends ConfigEventState {}

final class ConfigUpdateGridState extends ConfigEventState {}
