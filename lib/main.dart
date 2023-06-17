import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';

import 'di/bl_bind_module.dart';
import 'di/ui_bind_module.dart';
import 'ui/app.dart';

void main() {
  setupDI();

  runApp(GetIt.I.get<App>());
}

void setupDI() {
  BlBindModule.provide();
  UiBindModule.provide();
}