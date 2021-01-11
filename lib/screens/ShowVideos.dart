import 'package:flutter/material.dart';
import 'package:videoplayer/Models/Video.dart';
import 'package:videoplayer/CallVideosApi.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

import '../UtilitiesKeys.dart';

class ShowVideos extends StatefulWidget {
  String search;
  ShowVideos(this.search);
  @override
  _ShowVideosState createState() => _ShowVideosState();
}

class _ShowVideosState extends State<ShowVideos> {
  CallVideosApi callVideo = CallVideosApi();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: callVideo.callVideos(widget.search),
      builder: (context, snapshot) {
        List<Video> videos = snapshot.data;
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return CircularProgressIndicator();
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasError) {
              return Text(
                'Erro ao carregar os dados',
              );
            }else {
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 4,
                  height: 0,
                  color: Colors.grey,
                ),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      FlutterYoutube.playYoutubeVideoById(
                          apiKey: API_KEY,
                          videoId: videos[index].id,
                          autoPlay: true,
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                videos[index].thumbnail,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            videos[index].title,
                          ),
                          subtitle: Text(
                            videos[index].channelTitle,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
        }
        return Center();
      },
    );
  }
}