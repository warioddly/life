part of 'config_bloc.dart';

@immutable
sealed class ConfigEvent {}

final class ConfigUpdateSpeed extends ConfigEvent {
  final double speed;
  ConfigUpdateSpeed(this.speed);
}

final class ConfigUpdateGrid extends ConfigEvent {
  final int grid;
  ConfigUpdateGrid(this.grid);
}

final class ConfigUpdatePlayOrPause extends ConfigEvent {
  final bool paused;
  ConfigUpdatePlayOrPause(this.paused);
}