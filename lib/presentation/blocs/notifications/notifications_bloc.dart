import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:iospush/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationsBloc() : super(const NotificationsState()) {
    
    on<NotificationStatusChanged>(_notificationStatusChanged);
 
    //verificar estado de las notificaciones
    _initialStatusCheck();

    //listener para notificaciones en Foreground
    _onForegroundMessage();

  }

  static Future<void> initializeFCM() async{
    
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  }

  void _notificationStatusChanged(NotificationStatusChanged event,Emitter<NotificationsState> emit){
    emit(
      state.copyWith(
        status: event.status
      )
    );

    _getFCMToken();
  }

  void _initialStatusCheck() async{
      final settings = await messaging.getNotificationSettings();
      add(NotificationStatusChanged(settings.authorizationStatus));
      _getFCMToken();
  }

  void _getFCMToken() async{
    final settings = await messaging.getNotificationSettings();
    if(settings.authorizationStatus != AuthorizationStatus.authorized) return;

    final token  = await messaging.getToken();
    print(token);
  }

  void _handleRemoteMessage(RemoteMessage message)
  {
    print('Got a message whilst in the fireground!');
    print('Message Data. ${message.data}');

    if(message.notification==null) return ;

    print('Message also contained a notification: ${message.notification}');
  }

  void _onForegroundMessage(){

    //si se quisiera limpiar las notificaciones sería:
    //final listener = FirebaseMessaging.onMessage.listen(_handleRemoteMessage);
    //listener.cancel();

    FirebaseMessaging.onMessage.listen(_handleRemoteMessage);

  }

  void requestPermission()async{
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: true,
        provisional: false,
        sound: true,
      );

      add(NotificationStatusChanged(settings.authorizationStatus));

      _getFCMToken();
  

    }

}
