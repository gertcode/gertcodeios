import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iospush/presentation/blocs/notifications/notifications_bloc.dart';


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(child:Text("Página Principal Notificaciones")),
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.read<NotificationsBloc>().requestPermission();
      },child: Icon(Icons.settings),),
    );
  }


}
