class Recipe {
  final String id;
  final String title;
  final String description;
  final List<String> ingredients;
  final String instructions;
  final String userId;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'userId': userId,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      ingredients: List<String>.from(map['ingredients']),
      instructions: map['instructions'],
      userId: map['userId'],
    );
  }
}