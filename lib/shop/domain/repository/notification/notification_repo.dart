import 'package:firebase_messaging/firebase_messaging.dart';

/// This is an abstract class that defines the contract for a notification repository.
///
/// The repository is responsible for handling notifications and interacting with
/// the underlying notification services. Concrete implementations of this class
/// will handle platform-specific notification logic.
abstract class NotificationRepo {
  /// Initializes the notification configuration.
  ///
  /// This method should be called at the app's startup to set up the notification
  /// services and configurations. The exact implementation will vary depending
  /// on the platform (iOS, Android, etc.).
  ///
  /// Throws an exception if there's an error during initialization.
  Future<void> initializeConfig();

  /// Retrieves the notification token for the device.
  ///
  /// The notification token is a unique identifier assigned by the notification
  /// service provider. It is used to send notifications to the device.
  ///
  /// Returns the notification token as a String, or null if the token is not available
  /// or there's an error during token retrieval.
  Future<String?> getToken();

  /// Callback function to handle foreground notification received event.
  ///
  /// This method is called when a notification is received while the app is in the foreground.
  /// Implementations of this method should handle the display of the received notification
  /// or perform any necessary actions based on the notification content.
  ///
  /// It can be left empty if foreground notification handling is not required for a specific
  /// implementation.
  Future<void> onForegroundNotificationReceived();

  /// Subscribes the device to a specific topic for push notifications.
  ///
  /// This method allows the app to receive push notifications related to a particular
  /// topic or channel. When the server sends a notification to that topic, the device
  /// will receive it if it is subscribed to the same topic.
  ///
  /// The [topic] parameter specifies the topic to subscribe to.
  /// Throws an exception if there's an error during subscription.
  Future<void> subscribeToTopic(String topic);

  /// Shows a local notification based on the received [message].
  ///
  /// The [message] parameter contains the data of the received notification,
  /// including the title and body to be displayed in the notification.
  /// The notification is displayed using [flutterLocalNotificationsPlugin],
  /// which handles the notification display on both Android and iOS.
  Future<void> showLocalNotification(RemoteMessage message);
}
