// ignore_for_file: deprecated_member_use

// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get homeTab => 'Home';

  @override
  String get skillsTab => 'Skills';

  @override
  String get profileTab => 'Profile';

  @override
  String get back => 'Back';

  @override
  String get homeGreeting => 'Hey, who do you want to chat with today?';

  @override
  String get homeSubtitle => 'Each friend has plenty of games waiting.';

  @override
  String get listeningFriend => 'Eavesdropping Mouse';

  @override
  String get speakingFriend => 'Chatty Parrot';

  @override
  String get readingFriend => 'Bookworm Owl';

  @override
  String get writingFriend => 'Scribbling Cat';

  @override
  String get skillsHeading => 'Play your\nown way.';

  @override
  String get skillsSubtitle => 'Four skills. So many journeys to explore.';

  @override
  String get listeningTitle => 'Listening';

  @override
  String get speakingTitle => 'Speaking';

  @override
  String get readingTitle => 'Reading';

  @override
  String get writingTitle => 'Writing';

  @override
  String get listeningDescription =>
      'Tune in to sounds and understand every story.';

  @override
  String get speakingDescription =>
      'Speak with confidence and start new conversations.';

  @override
  String get readingDescription => 'Discover the meaning behind every line.';

  @override
  String get writingDescription =>
      'Gather your ideas and write what you want to say.';

  @override
  String get orderTitle => 'Get the Order Right';

  @override
  String get orderDescription =>
      'Listen to customers and pick the right order.';

  @override
  String get detectiveTitle => 'Sound Detective';

  @override
  String get detectiveDescription =>
      'Listen to conversations and uncover the clues.';

  @override
  String get travelTitle => 'Your First Trip';

  @override
  String get travelDescription => 'Practise conversations for your travels.';

  @override
  String get storyTitle => 'Story Relay';

  @override
  String get storyDescription => 'Keep a story going with your own words.';

  @override
  String get roomTitle => 'Escape Room Code';

  @override
  String get roomDescription =>
      'Read the clues and piece the information together.';

  @override
  String get treasureTitle => 'Treasure Map';

  @override
  String get treasureDescription => 'Follow a trail of notes on an adventure.';

  @override
  String get robotTitle => 'Robot Commander';

  @override
  String get robotDescription =>
      'Write instructions to help your robot friend find the way.';

  @override
  String get messageTitle => 'Secret Messages';

  @override
  String get messageDescription => 'Connect with characters through messages.';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get shortDuration => '3–5 min';

  @override
  String get longDuration => '5–7 min';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get viewInformation => 'View information';

  @override
  String get gameUnavailable => 'Mini-games will be added later.';

  @override
  String get waitForGames => 'New games are on the way';

  @override
  String get gameCorner => 'Mini-game corner';

  @override
  String get gamePreviewNotice =>
      'Game ideas in this preview. More content is on the way.';

  @override
  String get headphonesHint => 'Put on headphones for more fun!';

  @override
  String get listeningGreeting => 'Are your ears ready?';

  @override
  String get listeningSubtitle => 'Pick a game and let’s listen together!';

  @override
  String get profileHeading => 'Your corner.';

  @override
  String get profileSubtitle => 'Every journey starts with giving it a try.';

  @override
  String get player => 'Player';

  @override
  String get localProfile => 'Profile on this device';

  @override
  String get profilePreview =>
      'You’re exploring the preview. No account needed to start this journey.';

  @override
  String get progressHeading => 'Progress, step by step';

  @override
  String get sampleData => 'Sample data';

  @override
  String get sampleGoal => 'Example weekly goal: 2 / 5 sessions';

  @override
  String get progressNotice =>
      'Your progress will appear when mini-games are added.';

  @override
  String get openSettings => 'App settings';

  @override
  String get brandTagline => 'PLAY & LEARN · A LITTLE EVERY DAY';

  @override
  String get settingsHeading => 'Make yourself\nat home.';

  @override
  String get settingsSubtitle => 'Make the experience your own.';

  @override
  String get reduceMotion => 'Reduce motion';

  @override
  String get reduceMotionDescription =>
      'Reduce movement when pressing buttons and changing screens.';

  @override
  String get settingsBusy => 'Saving or loading settings…';

  @override
  String get settingsBusySemantics => 'Processing settings';

  @override
  String get deviceMotionNotice =>
      'The app also respects your device’s reduced motion preference.';

  @override
  String get retry => 'Retry';

  @override
  String get settingsStorageNotice =>
      'Changes are kept on this device after saving successfully. You can explore the app offline.';

  @override
  String get settingsReadError => 'Could not load settings. Please try again.';

  @override
  String get settingsWriteError =>
      'Could not save your changes. Please try again.';

  @override
  String get language => 'Language';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '1 day',
    );
    return 'Learning streak: $_temp0';
  }

  @override
  String gameCountSoon(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count games',
      one: '1 game',
    );
    return '$_temp0 · Coming soon';
  }

  @override
  String listeningGameCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count games',
      one: '1 game',
    );
    return '$_temp0 · Have fun listening to English';
  }
}
