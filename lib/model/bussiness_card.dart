// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:typed_data';

class BusinessCard {
  String name;
  String eMail;
  String phoneNumber;
  String address;
  String website;
  Uint8List image;
  BusinessCard({
    required this.name,
    required this.eMail,
    required this.phoneNumber,
    required this.address,
    required this.website,
    required this.image,
  });

  BusinessCard copyWith({
    String? name,
    String? eMail,
    String? phoneNumber,
    String? address,
    String? website,
    Uint8List? image,
  }) {
    return BusinessCard(
      name: name ?? this.name,
      eMail: eMail ?? this.eMail,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      website: website ?? this.website,
      image: image ?? this.image,
    );
  }

  factory BusinessCard.fromMap(Map<String, dynamic> map) {
    return BusinessCard(
      name: map['name'] as String,
      eMail: map['eMail'] as String,
      phoneNumber: map['phoneNumber'] as String,
      address: map['address'] as String,
      website: map['website'] as String,
      image: base64Decode(map['image'] as String),
    );
  }

  factory BusinessCard.fromJson(String source) =>
      BusinessCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessCard(name: $name, eMail: $eMail, phoneNumber: $phoneNumber, address: $address, website: $website, image: $image)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'eMail': eMail,
      'phoneNumber': phoneNumber,
      'address': address,
      'website': website,
      'image': base64Encode(image),
    };
  }

  String toJson() => json.encode(toMap());
}
