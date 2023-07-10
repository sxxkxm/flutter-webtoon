import 'dart:ui';

import 'package:webtoon/models/webtoon.dart';
import '../utils/color_utils.dart';

class BannerModel {
  final String thumbnail;
  final String tag;
  final Color color;

  BannerModel.fromJson(Map<String, dynamic> json)
      : thumbnail = json['thumbnail'] ?? '',
        tag = json['tag'] ?? '',
        color = getColorFromHex(json['color'] ?? '#FFFFFF');

  factory BannerModel.fromTypedJson(Map<String, dynamic> json) {
    switch (json['type']) {
      case 10:
        return WebtoonBannerModel.fromJson(json);
      case 20:
        return EventBannerModel.fromJson(json);
      default:
        throw Exception("Unknown banner type: ${json['type']}");
    }
  }
}

class WebtoonBannerModel extends BannerModel {
  final WebtoonModel webtoon;

  WebtoonBannerModel.fromJson(Map<String, dynamic> json)
      : webtoon = WebtoonModel.fromJson(json['webtoon']),
        super.fromJson(json);
}

class EventBannerModel extends BannerModel {
  final String title;
  final String content;

  EventBannerModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        content = json['content'] ?? '',
        super.fromJson(json);
}
