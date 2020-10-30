import 'dart:convert';
import 'dart:io';
import 'package:flutter_firebase_login/youtube_models/video_model.dart';
import 'package:flutter_firebase_login/youtube_models/channel_model.dart';
import 'package:flutter_firebase_login/youtube_utilities/keys.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService._instantiate();

  static final APIService instance = APIService._instantiate();

  final String _baseUrl = 'www.googleapis.com';
  String _nextPageToken = '';

  Future<Channel> fetchChannel({String channelId}) async {
    Map<String, String> parameters = {
      'part': 'snippet, contentDetails, statistics',
      'id': channelId,
      'key': API_KEY,
    };

    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/channels',
      parameters,
    );

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // 채널 얻어오기
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body)['items'][0];
      Channel channel = Channel.fromMap(data);

      // 업로드한 재생 목록에서 첫번째 동영상 가져오기
      channel.videos = await fetchVideosFromPlaylist(
        playlistId: channel.uploadPlaylistId,
      );
      return channel;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  Future<List<Video>> fetchVideosFromPlaylist({String playlistId}) async {
    Map<String, String> parameters = {
      'part': 'snippet',
      'playlistId': playlistId,
      'maxResults': '8',
      'pageToken': _nextPageToken,
      'key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/youtube/v3/playlistItems',
      parameters,
    );
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };

    // 영상의 플레이리스트 가져오기
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      _nextPageToken = data['nextPageToken'] ?? '';
      List<dynamic> videosJson = data['items'];

      // 업로드한 재생 목록에서 첫 8개 영상 가져오기
      List<Video> videos = [];
      videosJson.forEach(
          (json) => videos.add(
            Video.fromMap(json['snippet']),
          ),
      );
      return videos;
    } else {
      throw json.decode(response.body) ['error']['message'];
    }
  }
}
