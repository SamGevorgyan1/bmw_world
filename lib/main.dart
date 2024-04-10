import 'package:bmw_world/application/features/bmw_world/presentation/app/main_app.dart';
import 'package:flutter/material.dart';

import 'application/injection_container.dart';

void main()  {
 initializeDependencies();
  runApp(const MainApp());
}
