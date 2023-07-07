import 'package:equatable/equatable.dart';

import '../../app/app_enums.dart';
import 'option_model.dart';

class QuestionModel extends Equatable {
  final int id;
  final QuestionType type;
  final String text;
  final List<OptionModel>? options;
  final bool isRequired;

  const QuestionModel({
    required this.id,
    required this.type,
    required this.text,
    this.options,
    required this.isRequired,
  });

  @override
  List<Object> get props => [id];
}
