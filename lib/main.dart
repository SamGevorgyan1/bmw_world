import 'package:bmw_world/application/app/main_app.dart';
import 'package:flutter/material.dart';

import 'application/di/injection_container.dart';

void main(){
  initializeDependencies();
  runApp(const MainApp());
}
