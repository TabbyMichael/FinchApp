class EcoDonation {
  final String id;
  final String name;
  final String category;
  final String description;

  EcoDonation({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
  });

  factory EcoDonation.fromDbMap(Map<String, dynamic> map) => EcoDonation(
    id: map['id'],
    name: map['name'],
    category: map['category'],
    description: map['description'],
  );

  Map<String, dynamic> toDbMap() => {
    'id': id,
    'name': name,
    'category': category,
    'description': description,
  };

  // Factory method to create an EcoDonation from JSON data (if needed for APIs)
  factory EcoDonation.fromJson(Map<String, dynamic> json) {
    return EcoDonation(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
    );
  }

  // Convert EcoDonation to JSON (if needed for APIs)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
    };
  }
}
