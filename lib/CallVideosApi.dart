import 'package:videoplayer/UtilitiesKeys.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Models/Video.dart';

class CallVideosApi {
  Future<List<Video>> callVideos(String search) async {
    http.Response response = await http.get(
        DEFAULT_URL + 'search'
            '?part=snippet'
            "&channelId=$CHANNEL_ID"
            '&maxResults=20'
            '&type=video'
            "&q=$search"
            "&key=$API_KEY"
    );
    print(response.statusCode);
    List<Video> videos = List();
    if(response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      videos = jsonData['items'].map<Video>(
              (json) {
            return Video.fromJson(json);
          }
      ).toList();
    }
    return videos;
  }
}