class HereResultList {
  HereResultList({
    this.results,
  });

  List<HereResult>? results;

  factory HereResultList.fromJson(Map<String, dynamic> json) => HereResultList(
        results: List<HereResult>.from(
            json["results"].map((x) => HereResult.fromJson(x))),
      );
}

class HereResult {
  HereResult({
    this.title,
    this.highlightedTitle,
    this.position,
  });

  String? title;
  String? highlightedTitle;
  List<double>? position;

  factory HereResult.fromJson(Map<String, dynamic> json) => HereResult(
        title: json["title"],
        highlightedTitle: json["highlightedTitle"],
        position: json["position"] != null
            ? List<double>.from(json["position"]?.map((x) => x.toDouble()))
            : null,
      );
}
