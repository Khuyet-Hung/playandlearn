import 'package:material_ui/material_ui.dart';

enum SkillId { listening, speaking, reading, writing }

@immutable
class Skill {
  const Skill({
    required this.id,
    required this.title,
    required this.englishTitle,
    required this.description,
    required this.icon,
    required this.color,
  });
  final SkillId id;
  final String title;
  final String englishTitle;
  final String description;
  final IconData icon;
  final Color color;
}
