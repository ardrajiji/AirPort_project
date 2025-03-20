// To parse this JSON data, do
//
//     final airportModel = airportModelFromJson(jsonString);

import 'dart:convert';

AirportModel airportModelFromJson(String str) => AirportModel.fromJson(json.decode(str));

String airportModelToJson(AirportModel data) => json.encode(data.toJson());

class AirportModel {
    int? took;
    bool? timedOut;
    Shards? shards;
    Hits? hits;

    AirportModel({
        this.took,
        this.timedOut,
        this.shards,
        this.hits,
    });

    factory AirportModel.fromJson(Map<String, dynamic> json) => AirportModel(
        took: json["took"],
        timedOut: json["timed_out"],
        shards: json["_shards"] == null ? null : Shards.fromJson(json["_shards"]),
        hits: json["hits"] == null ? null : Hits.fromJson(json["hits"]),
    );

    Map<String, dynamic> toJson() => {
        "took": took,
        "timed_out": timedOut,
        "_shards": shards?.toJson(),
        "hits": hits?.toJson(),
    };
}

class Hits {
    int? total;
    dynamic maxScore;
    List<Hit>? hits;

    Hits({
        this.total,
        this.maxScore,
        this.hits,
    });

    factory Hits.fromJson(Map<String, dynamic> json) => Hits(
        total: json["total"],
        maxScore: json["max_score"],
        hits: json["hits"] == null ? [] : List<Hit>.from(json["hits"]!.map((x) => Hit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "max_score": maxScore,
        "hits": hits == null ? [] : List<dynamic>.from(hits!.map((x) => x.toJson())),
    };
}

class Hit {
    Index? index;
    Type? type;
    String? id;
    dynamic score;
    Source? source;

    Hit({
        this.index,
        this.type,
        this.id,
        this.score,
        this.source,
    });

    factory Hit.fromJson(Map<String, dynamic> json) => Hit(
        index: indexValues.map[json["_index"]]!,
        type: typeValues.map[json["_type"]]!,
        id: json["_id"],
        score: json["_score"],
        source: json["_source"] == null ? null : Source.fromJson(json["_source"]),
    );

    Map<String, dynamic> toJson() => {
        "_index": indexValues.reverse[index],
        "_type": typeValues.reverse[type],
        "_id": id,
        "_score": score,
        "_source": source?.toJson(),
    };
}

enum Index {
    Q8_BOOKINGAIRPORT
}

final indexValues = EnumValues({
    "q8bookingairport": Index.Q8_BOOKINGAIRPORT
});

class Source {
    int? id;
    String? code;
    String? name;
    String? arabicname;
    String? city;
    String? arabiccity;
    String? countrycode;
    String? countryname;
    String? arabiccountryname;
    bool? isdomestic;
    bool? isallairport;
    bool? hidden;
    int? ranking;
    int? parentid;
    String? longitude;
    String? latitude;
    dynamic displayname;
    dynamic displaynamear;

    Source({
        this.id,
        this.code,
        this.name,
        this.arabicname,
        this.city,
        this.arabiccity,
        this.countrycode,
        this.countryname,
        this.arabiccountryname,
        this.isdomestic,
        this.isallairport,
        this.hidden,
        this.ranking,
        this.parentid,
        this.longitude,
        this.latitude,
        this.displayname,
        this.displaynamear,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        arabicname: json["arabicname"],
        city: json["city"],
        arabiccity: json["arabiccity"],
        countrycode: json["countrycode"],
        countryname: json["countryname"],
        arabiccountryname: json["arabiccountryname"],
        isdomestic: json["isdomestic"],
        isallairport: json["isallairport"],
        hidden: json["hidden"],
        ranking: json["ranking"],
        parentid: json["parentid"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        displayname: json["displayname"],
        displaynamear: json["displaynamear"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "arabicname": arabicname,
        "city": city,
        "arabiccity": arabiccity,
        "countrycode": countrycode,
        "countryname": countryname,
        "arabiccountryname": arabiccountryname,
        "isdomestic": isdomestic,
        "isallairport": isallairport,
        "hidden": hidden,
        "ranking": ranking,
        "parentid": parentid,
        "longitude": longitude,
        "latitude": latitude,
        "displayname": displayname,
        "displaynamear": displaynamear,
    };
}

enum Type {
    AIRPORTLIST
}

final typeValues = EnumValues({
    "airportlist": Type.AIRPORTLIST
});

class Shards {
    int? total;
    int? successful;
    int? skipped;
    int? failed;

    Shards({
        this.total,
        this.successful,
        this.skipped,
        this.failed,
    });

    factory Shards.fromJson(Map<String, dynamic> json) => Shards(
        total: json["total"],
        successful: json["successful"],
        skipped: json["skipped"],
        failed: json["failed"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "successful": successful,
        "skipped": skipped,
        "failed": failed,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
