import 'package:equatable/equatable.dart';

import '../../app/app_enums.dart';

class OptionModel extends Equatable {
  final int id;
  final String text;
  final OptionType type;

  const OptionModel({
    required this.id,
    required this.text,
    required this.type,
  });

  @override
  List<Object> get props => [id];
}
