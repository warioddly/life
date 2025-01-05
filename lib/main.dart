import 'package:flame/camera.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life/game/bloc/config_bloc.dart';
import 'game/game.dart';

void main() {
  runApp(const Life());
}

class Life extends StatefulWidget {
  const Life({super.key});

  @override
  State<Life> createState() => _LifeState();
}

class _LifeState extends State<Life> {

  final configBloc = ConfigBloc();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("LIFE"),
            centerTitle: true,
          ),
          body: Column(
            children: [

              Expanded(
                child: GameWidget(
                  game: LifeGame(
                      configBloc: configBloc,
                      camera: CameraComponent.withFixedResolution(
                        width: size.width + 300,
                        height: size.height + 300,
                      )
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    BlocBuilder(
                      bloc: configBloc,
                      builder: (context, ConfigState state) {
                        final paused = state.model.paused;
                        return ElevatedButton(
                          onPressed: () {
                            configBloc.add(ConfigUpdatePlayOrPause(!paused));
                          },
                          child: Text(paused ? "Play" : "Pause"),
                        );
                      },
                    ),

                    BlocBuilder(
                      bloc: configBloc,
                      builder: (context, ConfigState state) {
                        final speed = state.model.speed;
                        return Slider(
                          value: speed,
                          min: 0,
                          max: 60,
                          label: speed.toString(),
                          onChanged: (double value) {
                            configBloc.add(ConfigUpdateSpeed(value));
                          },
                        );
                      },
                    ),

                    BlocBuilder(
                      bloc: configBloc,
                      builder: (context, ConfigState state) {
                        final grid = state.model.grid;
                        return Slider(
                          value: grid.toDouble(),
                          min: 0,
                          max: 300,
                          label: grid.toString(),
                          onChanged: (double value) {
                            configBloc.add(ConfigUpdateGrid(value.toInt()));
                          },
                        );
                      },
                    ),

                  ],
                ),
              )

            ],
          ),
      ),
    );
  }
}

