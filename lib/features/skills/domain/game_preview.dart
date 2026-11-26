import 'package:flutter/foundation.dart';

import 'skill.dart';

@immutable
class GamePreview {
  const GamePreview({
    required this.id,
    required this.skillId,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.duration,
  });
  final String id;
  final SkillId skillId;
  final String title;
  final String description;
  final String difficulty;
  final String duration;
}
