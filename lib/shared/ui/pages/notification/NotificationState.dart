import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationState {
  bool isReceived;
  ReceivedAction? initialAction;

  NotificationState({
    this.isReceived = false,
    this.initialAction = null,
  });

  NotificationState copyWith({
    bool? isReceived,
    ReceivedAction? initialAction,
  }) =>
      NotificationState(
        isReceived: isReceived ?? this.isReceived,
        initialAction: initialAction ?? this.initialAction,
      );
}