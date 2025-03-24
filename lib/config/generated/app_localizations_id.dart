// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get title => 'College Scheduler';

  @override
  String get deleteConfirmationTitle => 'Konfirmasi Penghapusan!';

  @override
  String get deleteDescription => 'Data yang terhapus tidak dapat dikembalikan. Apakah Anda yakin ingin menghapusnya?';

  @override
  String get deleteCancelButton => 'Batal';

  @override
  String get deleteProceedButton => 'Ya, Hapus';

  @override
  String get quoteAfterLogin => '\"WAKTU TERBAIK UNTUK MENANAM POHON ADALAH 20 TAHUN YANG LALU, WAKTU TERBAIK KEDUA ADALAH SEKARANG\"';

  @override
  String get quoteAfterLoginMark => '~ Pepatah Cina';

  @override
  String gettingDataSuccess(Object feature) {
    return 'Successfully getting data $feature';
  }

  @override
  String creatingDataSuccess(Object feature) {
    return 'Successfully creating data $feature';
  }

  @override
  String updatingDataSuccess(Object feature) {
    return 'Successfully updating data $feature';
  }

  @override
  String deletingDataSuccess(Object feature) {
    return 'Successfully deleting data $feature';
  }

  @override
  String gettingDataEmpty(Object feature) {
    return 'You don\'t have data on $feature';
  }

  @override
  String gettingDataProblem(Object feature) {
    return 'There\'s a problem when getting $feature data';
  }

  @override
  String creatingDataProblem(Object feature) {
    return 'There\'s a problem when creating $feature data';
  }

  @override
  String updatingDataProblem(Object feature) {
    return 'There\'s a problem when updating $feature data';
  }

  @override
  String deletingDataProblem(Object feature) {
    return 'There\'s a problem when deleting $feature data';
  }

  @override
  String get homeMenuButton => 'Home';

  @override
  String get eventsMenuButton => 'Events';

  @override
  String get settingsMenuButton => 'Settings';

  @override
  String get changeFullnameOrUsernameTitle => 'Change Fullname Or Username';

  @override
  String get fullnameLabel => 'Fullname';

  @override
  String get fullnamehint => 'Input your new Fullname';

  @override
  String get fullnameEmptyError => 'Please input your new Fullname';

  @override
  String get usernameLabel => 'Username';

  @override
  String get usernameHint => 'Input your new Username';

  @override
  String get usernameEmptyError => 'Please input your new Username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordChangeFullnameUsernameHint => 'Input your password for validation account';

  @override
  String get passwordEmptyError => 'Please input your password for security purpose';

  @override
  String get changingFullnameUsernamePasswordDisclamer => 'For security purpose, please insert your account password, so that we can know this is you who trying to change the username';

  @override
  String get changeFullnameUsernameFailedTitle => 'Change Fullname or Username failed';

  @override
  String get emptyFieldError => 'Please fill the requierd data';

  @override
  String get submitChange => 'Submit Changes';

  @override
  String greetingFriend(Object user) {
    return 'Welcome Back! \n$user';
  }

  @override
  String get dataStatusTitle => 'Data Status';

  @override
  String get idleStatus => 'IDLE';

  @override
  String get progressStatus => 'PROGESS';

  @override
  String get doneStatus => 'DONE';

  @override
  String get dataPriorityTitle => 'Data Priority';

  @override
  String get lowPriority => 'LOW';

  @override
  String get mediumPriority => 'MEDIUM';

  @override
  String get highPriority => 'HIGH';

  @override
  String get coreMenuTitle => 'Core Menu';

  @override
  String get dataClassTitle => 'Data Class';

  @override
  String get dataEventsTitle => 'Data Events';

  @override
  String get dataLecturerTitle => 'Data Lecturer';

  @override
  String get recentDataEvents => 'Recent Data Events';

  @override
  String get createDataClass => 'Create Data Class';

  @override
  String get editButton => 'Edit';

  @override
  String get deleteButton => 'Delete';

  @override
  String get searchItemByTitle => 'Search Item By Title';

  @override
  String get filterEvents => 'Filter Events';

  @override
  String get dateOfEventsLabel => 'Date Of Event';

  @override
  String get dateOfEventsHint => 'Please input Date Of Event';

  @override
  String get priorityLabel => 'Priority';

  @override
  String get prioritySelect => 'Select Priority';

  @override
  String get statusLabel => 'Status';

  @override
  String get statusSelect => 'Select Status';

  @override
  String get clearButton => 'Clear';

  @override
  String get submitButton => 'Submit';

  @override
  String get deadlineLabel => 'Deadline';

  @override
  String get createDataLecturer => 'Create Data Lecturer';

  @override
  String get detailEventTitle => 'Detail Event';

  @override
  String get startHourLabel => 'Start Hour';

  @override
  String get endHourLabel => 'End Hour';

  @override
  String get locationLabel => 'Location';

  @override
  String get classNameLabel => 'Class Name';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get eventHistory => 'Event History';
}
