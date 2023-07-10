class WebtoonModel {
  final String title;
  final String thumb;
  final String id;
  final String artist;

  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'] ?? '',
        id = json['id'],
        artist = json['artist'] ?? '';
}
