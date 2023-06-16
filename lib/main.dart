import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'ui/app.dart';
import 'di/blocs_bind_module.dart';
import 'di/widgets_bind_module.dart';

void main() {
  setupDI();

  runApp(GetIt.I.get<App>());
}

void setupDI() {
  BlocsBindModule.provide();
  WidgetsBindModule.provide();
}