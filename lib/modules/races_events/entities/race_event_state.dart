class RaceEvent {
  final String id;
  final String title;
  final int distance;
  final int startDate;
  final String address;
  final String ownerID;
  final String? photo;
  final int? minAge;
  final int? maxAge;
  final int? gender;
  final int? maxMembers;
  final Map<String, bool> members;
  final List<String> imageUrls;
  final List<String> links;

  RaceEvent(
      {required this.id,
      required this.title,
      required this.distance,
      required this.startDate,
      required this.address,
      required this.ownerID,
      this.photo,
      this.minAge,
      this.maxAge,
      this.gender,
      this.maxMembers,
      required this.members,
      required this.imageUrls,
      required this.links});

  factory RaceEvent.fromJson(Map<dynamic, dynamic> json) {
    Map<String, bool> members = {};
    if (json['members'] != null) {
      json['members'].forEach((key, value) {
        members[key] = value;
      });
    }

    return RaceEvent(
      id: json['id'],
      title: json['title'],
      distance: json['distance'],
      startDate: json['startDate'],
      address: json['address'],
      ownerID: json['ownerID'],
      photo: json['photo'],
      minAge: json['minAge'],
      maxAge: json['maxAge'],
      gender: json['gender'],
      maxMembers: json['maxMembers'],
      members: members,
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      links: List<String>.from(json['links'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'id': id,
      'title': title,
      'distance': distance,
      'startDate': startDate,
      'address': address,
      'ownerID': ownerID,
      'photo': photo,
      'minAge': minAge,
      'maxAge': maxAge,
      'gender': gender,
      'maxMembers': maxMembers,
      'imageUrls': imageUrls,
      'links': links,
    };

    if (members.isNotEmpty) {
      json['members'] = members;
    }

    return json;
  }
}
