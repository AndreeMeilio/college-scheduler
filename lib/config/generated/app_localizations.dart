import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id')
  ];

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'College Scheduler'**
  String get title;

  /// No description provided for @deleteConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Deletion!'**
  String get deleteConfirmationTitle;

  /// No description provided for @deleteDescription.
  ///
  /// In en, this message translates to:
  /// **'The deleted data cannot be restored, Are you sure you want to delete it?'**
  String get deleteDescription;

  /// No description provided for @deleteCancelButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get deleteCancelButton;

  /// No description provided for @deleteProceedButton.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete it'**
  String get deleteProceedButton;

  /// No description provided for @quoteAfterLogin.
  ///
  /// In en, this message translates to:
  /// **'\"THE BEST TIME TO GROW A TREE IS 20 YEARS AGO, THE SECOND BEST TIME IS NOW\"'**
  String get quoteAfterLogin;

  /// No description provided for @quoteAfterLoginMark.
  ///
  /// In en, this message translates to:
  /// **'~ Chinese Proverb'**
  String get quoteAfterLoginMark;

  /// Generic description for getting data success
  ///
  /// In en, this message translates to:
  /// **'Successfully getting data {feature}'**
  String gettingDataSuccess(Object feature);

  /// Generic description for creating data success
  ///
  /// In en, this message translates to:
  /// **'Successfully creating data {feature}'**
  String creatingDataSuccess(Object feature);

  /// Generic description for updating data success
  ///
  /// In en, this message translates to:
  /// **'Successfully updating data {feature}'**
  String updatingDataSuccess(Object feature);

  /// Generic description for deleting data success
  ///
  /// In en, this message translates to:
  /// **'Successfully deleting data {feature}'**
  String deletingDataSuccess(Object feature);

  /// Generic description for empty getting data
  ///
  /// In en, this message translates to:
  /// **'You don\'t have data on {feature}'**
  String gettingDataEmpty(Object feature);

  /// Generic description for problem getting data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when getting {feature} data'**
  String gettingDataProblem(Object feature);

  /// Generic description for problem creating data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when creating {feature} data'**
  String creatingDataProblem(Object feature);

  /// Generic description for problem updating data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when updating {feature} data'**
  String updatingDataProblem(Object feature);

  /// Generic description for problem deleting data
  ///
  /// In en, this message translates to:
  /// **'There\'s a problem when deleting {feature} data'**
  String deletingDataProblem(Object feature);

  /// No description provided for @homeMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeMenuButton;

  /// No description provided for @eventsMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsMenuButton;

  /// No description provided for @settingsMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsMenuButton;

  /// No description provided for @changeFullnameOrUsernameTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Fullname Or Username'**
  String get changeFullnameOrUsernameTitle;

  /// No description provided for @fullnameLabel.
  ///
  /// In en, this message translates to:
  /// **'Fullname'**
  String get fullnameLabel;

  /// No description provided for @fullnamehint.
  ///
  /// In en, this message translates to:
  /// **'Input your new Fullname'**
  String get fullnamehint;

  /// No description provided for @fullnameEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please input your new Fullname'**
  String get fullnameEmptyError;

  /// No description provided for @usernameLabel.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// No description provided for @usernameHint.
  ///
  /// In en, this message translates to:
  /// **'Input your new Username'**
  String get usernameHint;

  /// No description provided for @usernameEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please input your new Username'**
  String get usernameEmptyError;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordChangeFullnameUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Input your password for validation account'**
  String get passwordChangeFullnameUsernameHint;

  /// No description provided for @passwordEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please input your password for security purpose'**
  String get passwordEmptyError;

  /// No description provided for @changingFullnameUsernamePasswordDisclamer.
  ///
  /// In en, this message translates to:
  /// **'For security purpose, please insert your account password, so that we can know this is you who trying to change the username'**
  String get changingFullnameUsernamePasswordDisclamer;

  /// No description provided for @changeFullnameUsernameFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Fullname or Username failed'**
  String get changeFullnameUsernameFailedTitle;

  /// No description provided for @emptyFieldError.
  ///
  /// In en, this message translates to:
  /// **'Please fill the requierd data'**
  String get emptyFieldError;

  /// No description provided for @submitChange.
  ///
  /// In en, this message translates to:
  /// **'Submit Changes'**
  String get submitChange;

  /// greeting user
  ///
  /// In en, this message translates to:
  /// **'Welcome Back! \n{user}'**
  String greetingFriend(Object user);

  /// No description provided for @dataStatusTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Status'**
  String get dataStatusTitle;

  /// No description provided for @idleStatus.
  ///
  /// In en, this message translates to:
  /// **'IDLE'**
  String get idleStatus;

  /// No description provided for @progressStatus.
  ///
  /// In en, this message translates to:
  /// **'PROGESS'**
  String get progressStatus;

  /// No description provided for @doneStatus.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get doneStatus;

  /// No description provided for @dataPriorityTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Priority'**
  String get dataPriorityTitle;

  /// No description provided for @lowPriority.
  ///
  /// In en, this message translates to:
  /// **'LOW'**
  String get lowPriority;

  /// No description provided for @mediumPriority.
  ///
  /// In en, this message translates to:
  /// **'MEDIUM'**
  String get mediumPriority;

  /// No description provided for @highPriority.
  ///
  /// In en, this message translates to:
  /// **'HIGH'**
  String get highPriority;

  /// No description provided for @coreMenuTitle.
  ///
  /// In en, this message translates to:
  /// **'Core Menu'**
  String get coreMenuTitle;

  /// No description provided for @dataClassTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Class'**
  String get dataClassTitle;

  /// No description provided for @dataEventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Events'**
  String get dataEventsTitle;

  /// No description provided for @dataLecturerTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Lecturer'**
  String get dataLecturerTitle;

  /// No description provided for @recentDataEvents.
  ///
  /// In en, this message translates to:
  /// **'Recent Data Events'**
  String get recentDataEvents;

  /// No description provided for @createDataClass.
  ///
  /// In en, this message translates to:
  /// **'Create Data Class'**
  String get createDataClass;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @deleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @searchItemByTitle.
  ///
  /// In en, this message translates to:
  /// **'Search Item By Title'**
  String get searchItemByTitle;

  /// No description provided for @filterEvents.
  ///
  /// In en, this message translates to:
  /// **'Filter Events'**
  String get filterEvents;

  /// No description provided for @dateOfEventsLabel.
  ///
  /// In en, this message translates to:
  /// **'Date Of Event'**
  String get dateOfEventsLabel;

  /// No description provided for @dateOfEventsHint.
  ///
  /// In en, this message translates to:
  /// **'Please input Date Of Event'**
  String get dateOfEventsHint;

  /// No description provided for @priorityLabel.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priorityLabel;

  /// No description provided for @prioritySelect.
  ///
  /// In en, this message translates to:
  /// **'Select Priority'**
  String get prioritySelect;

  /// No description provided for @statusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get statusLabel;

  /// No description provided for @statusSelect.
  ///
  /// In en, this message translates to:
  /// **'Select Status'**
  String get statusSelect;

  /// No description provided for @clearButton.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clearButton;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @deadlineLabel.
  ///
  /// In en, this message translates to:
  /// **'Deadline'**
  String get deadlineLabel;

  /// No description provided for @createDataLecturer.
  ///
  /// In en, this message translates to:
  /// **'Create Data Lecturer'**
  String get createDataLecturer;

  /// No description provided for @detailEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Detail Event'**
  String get detailEventTitle;

  /// No description provided for @startHourLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Hour'**
  String get startHourLabel;

  /// No description provided for @endHourLabel.
  ///
  /// In en, this message translates to:
  /// **'End Hour'**
  String get endHourLabel;

  /// No description provided for @locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get locationLabel;

  /// No description provided for @classNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Class Name'**
  String get classNameLabel;

  /// No description provided for @descriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get descriptionLabel;

  /// No description provided for @eventHistory.
  ///
  /// In en, this message translates to:
  /// **'Event History'**
  String get eventHistory;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'id': return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
