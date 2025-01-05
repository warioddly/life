import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/game/core/configs.dart';
import 'package:meta/meta.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {

  ConfigBloc() : super(ConfigState.initial()) {
    on<ConfigUpdateSpeed>(updateSpeed);
    on<ConfigUpdateGrid>(updateGrid);
    on<ConfigUpdatePlayOrPause>(updatePlayOrPause);
  }

  void updateSpeed(ConfigUpdateSpeed event, Emitter<ConfigState> emit) {
    emit(ConfigState(
      model: state.model.copyWith(
        speed: event.speed,
      ),
      state: ConfigInitial(),
    ));
  }

  void updateGrid(ConfigUpdateGrid event, Emitter<ConfigState> emit) {
    emit(ConfigState(
      model: state.model.copyWith(
        grid: event.grid,
      ),
      state: ConfigUpdateGridState(),
    ));
  }

  void updatePlayOrPause(ConfigUpdatePlayOrPause event, Emitter<ConfigState> emit) {
    emit(ConfigState(
      model: state.model.copyWith(
        paused: event.paused,
      ),
      state: ConfigInitial(),
    ));
  }

}
