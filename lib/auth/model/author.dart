class Author {
  final String id;
  final String name;
  final String userEmail;
  final String userProfileImage;
  final String phoneNumber;
  final String description;

  Author({
    required this.id,
    required this.name,
    required this.userEmail,
    required this.userProfileImage,
    required this.phoneNumber,
    required this.description,
  });

  // Factory method to create an Author object from JSON
  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      name: json['name'],
      userEmail: json['userEmail'],
      userProfileImage: json['userprofileimage'],
      phoneNumber: json['phoneNumber'],
      description: json['description'],
    );
  }

  // Convert an Author object to JSON for database updates
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'userEmail': userEmail,
      'userprofileimage': userProfileImage,
      'phoneNumber': phoneNumber,
      'description': description,
    };
  }
}
