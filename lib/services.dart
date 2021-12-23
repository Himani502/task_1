import 'dart:async';
import 'dart:convert';
import 'package:task_1/global.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Photos {
  String albumId;
  String id;
  String title;
  String url;
  String thumbnailUrl;

  Photos({
    this.albumId, this.id, this.title, this.url, this.thumbnailUrl
  });
}

Future<List<Photos>> getPhotos() async {
  print('https://jsonplaceholder.typicode.com/photos');
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  List responseJson = json.decode(response.body.toString());
  List<Photos> photos = createPhotosList(responseJson);
  return photos;
}

List<Photos> createPhotosList(List data) {
  List<Photos> list = new List();
  for (int i = 0; i < data.length ; i++) {
    String AlbumId = data[i]["albumId"].toString();
    String Id = data[i]["id"].toString();
    String Title = data[i]["title"].toString();
    String Url = data[i]["url"];
    String ThumbnailUrl = data[i]["thumbnailUrl"];

    Photos row = new Photos(
        albumId: AlbumId, id: Id, title: Title, url: Url, thumbnailUrl: ThumbnailUrl
    );
    list.add(row);
  }
  return list;
}


class Posts {
  String userId;
  String id;
  String title;
  String body;

  Posts({
    this.userId, this.id, this.title, this.body
  });
}

Future<List<Photos>> getPosts() async {
  print('https://jsonplaceholder.typicode.com/posts');
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  List responseJson = json.decode(response.body.toString());
  List<Photos> photos = createPhotosList(responseJson);
  return photos;
}

List<Posts> createPostsList(List data) {
  List<Posts> list = new List();
  for (int i = 0; i < data.length ; i++) {
    String UserId = data[i]["userId"].toString();
    String Id = data[i]["id"].toString();
    String Title = data[i]["title"].toString();
    String Body = data[i]["body"];

    Posts row = new Posts(
        userId: UserId, id: Id, title: Title, body: Body
    );
    list.add(row);
  }
  return list;
}
