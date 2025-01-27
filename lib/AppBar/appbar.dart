import 'package:flutter/material.dart';

class appBar_Principal extends StatefulWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  appBar_Principal({super.key, required this.actions});
  String title = 'App bar';
  List<Widget> actions = [];

  @override
  State<appBar_Principal> createState() => _appBar_PrincipalState();



}

class _appBar_PrincipalState extends State<appBar_Principal> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
          },
        ),

        ...widget.actions,
      ],


    );
  }
}

