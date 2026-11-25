import 'package:material_ui/material_ui.dart';

import '../../../core/theme/app_colors.dart';
import '../domain/game_preview.dart';
import '../domain/skill.dart';

abstract final class PreviewCatalog {
  static const skills = <Skill>[
    Skill(
      id: SkillId.listening,
      title: 'Luyện nghe',
      englishTitle: 'Listening',
      description: 'Bắt nhịp âm thanh, hiểu từng câu chuyện.',
      icon: Icons.headphones_rounded,
      color: AppColors.blue,
    ),
    Skill(
      id: SkillId.speaking,
      title: 'Luyện nói',
      englishTitle: 'Speaking',
      description: 'Cất tiếng tự tin, mở thêm cuộc trò chuyện.',
      icon: Icons.mic_none_rounded,
      color: AppColors.coral,
    ),
    Skill(
      id: SkillId.reading,
      title: 'Luyện đọc',
      englishTitle: 'Reading',
      description: 'Khám phá ý nghĩa đằng sau từng dòng chữ.',
      icon: Icons.auto_stories_outlined,
      color: AppColors.mint,
    ),
    Skill(
      id: SkillId.writing,
      title: 'Luyện viết',
      englishTitle: 'Writing',
      description: 'Gom ý tưởng, viết nên điều bạn muốn nói.',
      icon: Icons.edit_outlined,
      color: AppColors.lavender,
    ),
  ];

  static const _games = <GamePreview>[
    GamePreview(
      id: 'listening-order',
      skillId: SkillId.listening,
      title: 'Giao đúng đơn',
      description: 'Lắng nghe và khám phá yêu cầu của vị khách.',
    ),
    GamePreview(
      id: 'listening-detective',
      skillId: SkillId.listening,
      title: 'Thám tử âm thanh',
      description: 'Tìm manh mối ẩn trong những cuộc hội thoại.',
    ),
    GamePreview(
      id: 'speaking-travel',
      skillId: SkillId.speaking,
      title: 'Chuyến đi đầu tiên',
      description: 'Làm quen với những tình huống giao tiếp khi du lịch.',
    ),
    GamePreview(
      id: 'speaking-story',
      skillId: SkillId.speaking,
      title: 'Kể chuyện tiếp sức',
      description: 'Dùng lời nói để tiếp nối một câu chuyện.',
    ),
    GamePreview(
      id: 'reading-room',
      skillId: SkillId.reading,
      title: 'Mật mã thoát phòng',
      description: 'Đọc manh mối và ghép các mảnh thông tin.',
    ),
    GamePreview(
      id: 'reading-treasure',
      skillId: SkillId.reading,
      title: 'Bản đồ kho báu',
      description: 'Khám phá một hành trình qua những mẩu ghi chú.',
    ),
    GamePreview(
      id: 'writing-robot',
      skillId: SkillId.writing,
      title: 'Chỉ huy robot',
      description: 'Viết chỉ dẫn để giúp người bạn máy tìm đường.',
    ),
    GamePreview(
      id: 'writing-message',
      skillId: SkillId.writing,
      title: 'Tin nhắn bí mật',
      description: 'Kết nối với nhân vật qua những dòng tin nhắn.',
    ),
  ];

  static List<GamePreview> gamesFor(SkillId id) =>
      List.unmodifiable(_games.where((game) => game.skillId == id));
}
