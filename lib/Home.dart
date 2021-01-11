import 'package:flutter/material.dart';
import 'package:videoplayer/CustomSearchDelegate.dart';
import 'package:videoplayer/screens/ShowVideos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _search = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reprodutor de vídeo',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String search = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
              setState(() {
                _search = search;
              });
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: ShowVideos(_search),
      ),
    );
  }
}