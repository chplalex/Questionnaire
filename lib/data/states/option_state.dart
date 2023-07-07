import 'package:equatable/equatable.dart';

import '../../app/app_enums.dart';

class OptionState extends Equatable {
  final int id;
  final String title;
  final OptionType type;
  final String? text;
  final bool isSelected;

  const OptionState({
    required this.id,
    required this.title,
    required this.type,
    this.text,
    required this.isSelected,
  });

  factory OptionState.empty() => const OptionState(
        id: -1,
        title: "",
        type: OptionType.open,
        text: "",
        isSelected: false,
      );

  OptionState copyWith({
    int? id,
    String? title,
    OptionType? type,
    String? text,
    bool? isSelected,
  }) =>
      OptionState(
        id: id ?? this.id,
        title: title ?? this.title,
        type: type ?? this.type,
        isSelected: isSelected ?? this.isSelected,
      );

  @override
  List<Object> get props => [
        id,
        title,
        type,
        if (text != null) text!,
        isSelected,
      ];
}
