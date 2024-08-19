// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);
import 'dart:convert';

import 'package:awesome_notifications/awesome_notifications.dart';

// Notification notificationFromJson(String str) => Notification.fromJson(json.decode(str));
// String notificationToJson(Notification data) => json.encode(data.toJson());

class NotificationPush {
    final int id;
    final String channelKey;
    final String title;
    final String body;
    final String bigPicture;
    final String largeIcon;
    final Map<String, String> payload;
    final List<NotificationActionButton> notificationActionButtons;
    
    NotificationPush({
      this.id = -1,
      this.channelKey = "alerts",
      required this.title,
      required this.body,
      this.bigPicture = "",
      this.largeIcon = "",
      this.payload = const <String, String>{},
      required this.notificationActionButtons,
    });

    NotificationPush copyWith({
        int? id,
        String? channelKey,
        String? title,
        String? body,
        String? bigPicture,
        String? largeIcon,
        Map<String, String>? payload,
        List<NotificationActionButton>? notificationActionButtons,
    }) =>
        NotificationPush(
            id: id ?? this.id,
            channelKey: channelKey ?? this.channelKey,
            title: title ?? this.title,
            body: body ?? this.body,
            bigPicture: bigPicture ?? this.bigPicture,
            largeIcon: largeIcon ?? this.largeIcon,
            payload: payload ?? this.payload,
            notificationActionButtons: notificationActionButtons ?? this.notificationActionButtons,
        );
    factory NotificationPush.fromJson(Map json) => NotificationPush(
        id: json["id"] ?? -1,
        channelKey: json["channelKey"] ?? "alerts",
        title: json["title"] ?? "" ,
        body: json["body"] ?? "" ,
        bigPicture: json["bigPicture"] ?? "",
        largeIcon: json["largeIcon"] ?? "" ,
        payload: json["payload"] ??  <String, String>{} ,
        notificationActionButtons: json["notificationActionButtons"] ?? <NotificationActionButton>[] ,
    );
    Map<String, dynamic> toJson() => {
        "id" : id,
        "channelKey": channelKey,
        "title": title,
        "body": body,
        "bigPicture": bigPicture,
        "largeIcon": largeIcon,
        "payload": payload,
        "notificationActionButtons": notificationActionButtons,
    };
}