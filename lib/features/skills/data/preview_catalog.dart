import '../../../l10n/app_localizations.dart';
import '../../../l10n/l10n.dart';

import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/game_preview.dart';
import '../domain/skill.dart';

abstract final class PreviewCatalog {
  static List<Skill> get skills => skillsFor(vietnameseStrings);

  static List<Skill> skillsFor(AppLocalizations strings) => <Skill>[
    Skill(
      id: SkillId.listening,
      title: strings.listeningTitle,
      englishTitle: 'Listening',
      description: strings.listeningDescription,
      icon: Icons.headphones_rounded,
      color: AppColors.blue,
    ),
    Skill(
      id: SkillId.speaking,
      title: strings.speakingTitle,
      englishTitle: 'Speaking',
      description: strings.speakingDescription,
      icon: Icons.mic_none_rounded,
      color: AppColors.coral,
    ),
    Skill(
      id: SkillId.reading,
      title: strings.readingTitle,
      englishTitle: 'Reading',
      description: strings.readingDescription,
      icon: Icons.auto_stories_outlined,
      color: AppColors.mint,
    ),
    Skill(
      id: SkillId.writing,
      title: strings.writingTitle,
      englishTitle: 'Writing',
      description: strings.writingDescription,
      icon: Icons.edit_outlined,
      color: AppColors.lavender,
    ),
  ];

  static List<GamePreview> _games(AppLocalizations strings) => <GamePreview>[
    GamePreview(
      id: 'listening-order',
      skillId: SkillId.listening,
      title: strings.orderTitle,
      description: strings.orderDescription,
      difficulty: strings.easy,
      duration: strings.shortDuration,
    ),
    GamePreview(
      id: 'listening-detective',
      skillId: SkillId.listening,
      title: strings.detectiveTitle,
      description: strings.detectiveDescription,
      difficulty: strings.medium,
      duration: strings.longDuration,
    ),
    GamePreview(
      id: 'speaking-travel',
      skillId: SkillId.speaking,
      title: strings.travelTitle,
      description: strings.travelDescription,
      difficulty: strings.easy,
      duration: strings.shortDuration,
    ),
    GamePreview(
      id: 'speaking-story',
      skillId: SkillId.speaking,
      title: strings.storyTitle,
      description: strings.storyDescription,
      difficulty: strings.easy,
      duration: strings.shortDuration,
    ),
    GamePreview(
      id: 'reading-room',
      skillId: SkillId.reading,
      title: strings.roomTitle,
      description: strings.roomDescription,
      difficulty: strings.easy,
      duration: strings.shortDuration,
    ),
    GamePreview(
      id: 'reading-treasure',
      skillId: SkillId.reading,
      title: strings.treasureTitle,
      description: strings.treasureDescription,
      difficulty: strings.easy,
      duration: strings.shortDuration,
    ),
    GamePreview(
      id: 'writing-robot',
      skillId: SkillId.writing,
      title: strings.robotTitle,
      description: strings.robotDescription,
      difficulty: strings.easy,
      duration: strings.shortDuration,
    ),
    GamePreview(
      id: 'writing-message',
      skillId: SkillId.writing,
      title: strings.messageTitle,
      description: strings.messageDescription,
      difficulty: strings.easy,
      duration: strings.shortDuration,
    ),
  ];

  static List<GamePreview> gamesFor(SkillId id, [AppLocalizations? strings]) =>
      List.unmodifiable(
        _games(strings ?? vietnameseStrings)
            .where((game) => game.skillId == id),
      );
}
