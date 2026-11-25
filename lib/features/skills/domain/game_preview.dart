import 'package:flutter/foundation.dart';

import 'skill.dart';

@immutable
class GamePreview {
  const GamePreview({
    required this.id,
    required this.skillId,
    required this.title,
    required this.description,
  });
  final String id;
  final SkillId skillId;
  final String title;
  final String description;
}
