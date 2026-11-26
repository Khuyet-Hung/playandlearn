// ignore_for_file: deprecated_member_use
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @homeTab.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTab;

  /// No description provided for @skillsTab.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skillsTab;

  /// No description provided for @profileTab.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTab;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hey, who do you want to chat with today?'**
  String get homeGreeting;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Each friend has plenty of games waiting.'**
  String get homeSubtitle;

  /// No description provided for @listeningFriend.
  ///
  /// In en, this message translates to:
  /// **'Eavesdropping Mouse'**
  String get listeningFriend;

  /// No description provided for @speakingFriend.
  ///
  /// In en, this message translates to:
  /// **'Chatty Parrot'**
  String get speakingFriend;

  /// No description provided for @readingFriend.
  ///
  /// In en, this message translates to:
  /// **'Bookworm Owl'**
  String get readingFriend;

  /// No description provided for @writingFriend.
  ///
  /// In en, this message translates to:
  /// **'Scribbling Cat'**
  String get writingFriend;

  /// No description provided for @skillsHeading.
  ///
  /// In en, this message translates to:
  /// **'Play your\nown way.'**
  String get skillsHeading;

  /// No description provided for @skillsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Four skills. So many journeys to explore.'**
  String get skillsSubtitle;

  /// No description provided for @listeningTitle.
  ///
  /// In en, this message translates to:
  /// **'Listening'**
  String get listeningTitle;

  /// No description provided for @speakingTitle.
  ///
  /// In en, this message translates to:
  /// **'Speaking'**
  String get speakingTitle;

  /// No description provided for @readingTitle.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get readingTitle;

  /// No description provided for @writingTitle.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get writingTitle;

  /// No description provided for @listeningDescription.
  ///
  /// In en, this message translates to:
  /// **'Tune in to sounds and understand every story.'**
  String get listeningDescription;

  /// No description provided for @speakingDescription.
  ///
  /// In en, this message translates to:
  /// **'Speak with confidence and start new conversations.'**
  String get speakingDescription;

  /// No description provided for @readingDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the meaning behind every line.'**
  String get readingDescription;

  /// No description provided for @writingDescription.
  ///
  /// In en, this message translates to:
  /// **'Gather your ideas and write what you want to say.'**
  String get writingDescription;

  /// No description provided for @orderTitle.
  ///
  /// In en, this message translates to:
  /// **'Get the Order Right'**
  String get orderTitle;

  /// No description provided for @orderDescription.
  ///
  /// In en, this message translates to:
  /// **'Listen to customers and pick the right order.'**
  String get orderDescription;

  /// No description provided for @detectiveTitle.
  ///
  /// In en, this message translates to:
  /// **'Sound Detective'**
  String get detectiveTitle;

  /// No description provided for @detectiveDescription.
  ///
  /// In en, this message translates to:
  /// **'Listen to conversations and uncover the clues.'**
  String get detectiveDescription;

  /// No description provided for @travelTitle.
  ///
  /// In en, this message translates to:
  /// **'Your First Trip'**
  String get travelTitle;

  /// No description provided for @travelDescription.
  ///
  /// In en, this message translates to:
  /// **'Practise conversations for your travels.'**
  String get travelDescription;

  /// No description provided for @storyTitle.
  ///
  /// In en, this message translates to:
  /// **'Story Relay'**
  String get storyTitle;

  /// No description provided for @storyDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep a story going with your own words.'**
  String get storyDescription;

  /// No description provided for @roomTitle.
  ///
  /// In en, this message translates to:
  /// **'Escape Room Code'**
  String get roomTitle;

  /// No description provided for @roomDescription.
  ///
  /// In en, this message translates to:
  /// **'Read the clues and piece the information together.'**
  String get roomDescription;

  /// No description provided for @treasureTitle.
  ///
  /// In en, this message translates to:
  /// **'Treasure Map'**
  String get treasureTitle;

  /// No description provided for @treasureDescription.
  ///
  /// In en, this message translates to:
  /// **'Follow a trail of notes on an adventure.'**
  String get treasureDescription;

  /// No description provided for @robotTitle.
  ///
  /// In en, this message translates to:
  /// **'Robot Commander'**
  String get robotTitle;

  /// No description provided for @robotDescription.
  ///
  /// In en, this message translates to:
  /// **'Write instructions to help your robot friend find the way.'**
  String get robotDescription;

  /// No description provided for @messageTitle.
  ///
  /// In en, this message translates to:
  /// **'Secret Messages'**
  String get messageTitle;

  /// No description provided for @messageDescription.
  ///
  /// In en, this message translates to:
  /// **'Connect with characters through messages.'**
  String get messageDescription;

  /// No description provided for @easy.
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @shortDuration.
  ///
  /// In en, this message translates to:
  /// **'3–5 min'**
  String get shortDuration;

  /// No description provided for @longDuration.
  ///
  /// In en, this message translates to:
  /// **'5–7 min'**
  String get longDuration;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @viewInformation.
  ///
  /// In en, this message translates to:
  /// **'View information'**
  String get viewInformation;

  /// No description provided for @gameUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Mini-games will be added later.'**
  String get gameUnavailable;

  /// No description provided for @waitForGames.
  ///
  /// In en, this message translates to:
  /// **'New games are on the way'**
  String get waitForGames;

  /// No description provided for @gameCorner.
  ///
  /// In en, this message translates to:
  /// **'Mini-game corner'**
  String get gameCorner;

  /// No description provided for @gamePreviewNotice.
  ///
  /// In en, this message translates to:
  /// **'Game ideas in this preview. More content is on the way.'**
  String get gamePreviewNotice;

  /// No description provided for @headphonesHint.
  ///
  /// In en, this message translates to:
  /// **'Put on headphones for more fun!'**
  String get headphonesHint;

  /// No description provided for @listeningGreeting.
  ///
  /// In en, this message translates to:
  /// **'Are your ears ready?'**
  String get listeningGreeting;

  /// No description provided for @listeningSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick a game and let’s listen together!'**
  String get listeningSubtitle;

  /// No description provided for @profileHeading.
  ///
  /// In en, this message translates to:
  /// **'Your corner.'**
  String get profileHeading;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Every journey starts with giving it a try.'**
  String get profileSubtitle;

  /// No description provided for @player.
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// No description provided for @localProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile on this device'**
  String get localProfile;

  /// No description provided for @profilePreview.
  ///
  /// In en, this message translates to:
  /// **'You’re exploring the preview. No account needed to start this journey.'**
  String get profilePreview;

  /// No description provided for @progressHeading.
  ///
  /// In en, this message translates to:
  /// **'Progress, step by step'**
  String get progressHeading;

  /// No description provided for @sampleData.
  ///
  /// In en, this message translates to:
  /// **'Sample data'**
  String get sampleData;

  /// No description provided for @sampleGoal.
  ///
  /// In en, this message translates to:
  /// **'Example weekly goal: 2 / 5 sessions'**
  String get sampleGoal;

  /// No description provided for @progressNotice.
  ///
  /// In en, this message translates to:
  /// **'Your progress will appear when mini-games are added.'**
  String get progressNotice;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'App settings'**
  String get openSettings;

  /// No description provided for @brandTagline.
  ///
  /// In en, this message translates to:
  /// **'PLAY & LEARN · A LITTLE EVERY DAY'**
  String get brandTagline;

  /// No description provided for @settingsHeading.
  ///
  /// In en, this message translates to:
  /// **'Make yourself\nat home.'**
  String get settingsHeading;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Make the experience your own.'**
  String get settingsSubtitle;

  /// No description provided for @reduceMotion.
  ///
  /// In en, this message translates to:
  /// **'Reduce motion'**
  String get reduceMotion;

  /// No description provided for @reduceMotionDescription.
  ///
  /// In en, this message translates to:
  /// **'Reduce movement when pressing buttons and changing screens.'**
  String get reduceMotionDescription;

  /// No description provided for @settingsBusy.
  ///
  /// In en, this message translates to:
  /// **'Saving or loading settings…'**
  String get settingsBusy;

  /// No description provided for @settingsBusySemantics.
  ///
  /// In en, this message translates to:
  /// **'Processing settings'**
  String get settingsBusySemantics;

  /// No description provided for @deviceMotionNotice.
  ///
  /// In en, this message translates to:
  /// **'The app also respects your device’s reduced motion preference.'**
  String get deviceMotionNotice;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @settingsStorageNotice.
  ///
  /// In en, this message translates to:
  /// **'Changes are kept on this device after saving successfully. You can explore the app offline.'**
  String get settingsStorageNotice;

  /// No description provided for @settingsReadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load settings. Please try again.'**
  String get settingsReadError;

  /// No description provided for @settingsWriteError.
  ///
  /// In en, this message translates to:
  /// **'Could not save your changes. Please try again.'**
  String get settingsWriteError;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'Learning streak: {count, plural, =1{1 day} other{{count} days}}'**
  String streakDays(int count);

  /// No description provided for @gameCountSoon.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 game} other{{count} games}} · Coming soon'**
  String gameCountSoon(int count);

  /// No description provided for @listeningGameCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 game} other{{count} games}} · Have fun listening to English'**
  String listeningGameCount(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
