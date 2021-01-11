class Video {
  String id;
  String title;
  String description;
  String thumbnail;
  String channelTitle;

  Video({this.id, this.title, this.description, this.thumbnail, this.channelTitle});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id']['videoId'],
      title: json['snippet']['title'],
      description: json['snippet']['description'],
      thumbnail: json['snippet']['thumbnails']['high']['url'],
      channelTitle: json['snippet']['channelTitle'],
    );
  }
}