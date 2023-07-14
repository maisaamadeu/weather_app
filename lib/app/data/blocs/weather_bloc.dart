// import 'package:aula_bloc_2023/app/data/blocs/tarefa_event.dart';
// import 'package:aula_bloc_2023/app/data/blocs/tarefa_state.dart';
// import 'package:aula_bloc_2023/app/data/models/tarefa_model.dart';
// import 'package:aula_bloc_2023/app/data/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class TarefaBloc extends Bloc<TarefaEvent, TarefaState> {
//   final _repository = TarefaRepository();

//   TarefaBloc() : super(TarefaInitialState()) {
//     on(_mapEventToState);
//   }

//   void _mapEventToState(TarefaEvent event, Emitter emit) async {
//     List<TarefaModel> tarefas = [];

//     emit(TarefaLoadingState());

//     if (event is GetTarefas) {
//       tarefas = await _repository.getTarefas();
//     } else if (event is PostTarefa) {
//       tarefas = await _repository.postTarefa(tarefa: event.tarefa);
//     } else if (event is DeleteTarefa) {
//       tarefas = await _repository.deleteTarefa(tarefa: event.tarefa);
//     }

//     emit(TarefaLoadedState(tarefas: tarefas));
//   }
// }

import 'package:weather_app/app/data/blocs/weather_event.dart';
import 'package:weather_app/app/data/blocs/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {}
