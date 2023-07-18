import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_app/app/app_widget.dart';

void main() {
  Animate.restartOnHotReload = true;
  runApp(const AppWidget());
}

  // // void initSharedPreferences() async {
  //   prefs = await SharedPreferences.getInstance();
  // //   List<String>? oldTarefas = prefs.getStringList('tarefas');
  // //   if (oldTarefas != null) {
  // //     if (oldTarefas.isNotEmpty) {
  // //       for (var tarefa in oldTarefas) {
  // //         ItemModel oldTarefa = ItemModel.fromJson(json.decode(tarefa));
  // //         tarefas.add(oldTarefa);
  // //       }
  // //       setState(() {});
  // //     }
  // //   }
  // // }