class TwitterUser {
  String? id;
  String? name;
  String? username;

  TwitterUser(this.id, this.name, this.username);

  Map toJson() {
    var map = {};
    map['id'] = id;
    map['name'] = name;
    map['username'] = username;
    return map;
  }

  static TwitterUser fromJson(Map json) {
    return TwitterUser(json['id'], json['name'], json['username']);
  }
}

class Tweet {
  String id;
  String text;

  Tweet(this.id, this.text);

  Map toJson() {
    var map = {};
    map['id'] = id;
    map['text'] = text;

    return map;
  }

  static Tweet? fromJson(Map json) {
    return Tweet(json['id'], json['text']);
  }
}
