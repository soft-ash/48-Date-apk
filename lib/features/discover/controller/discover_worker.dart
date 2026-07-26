import '../model/discover_user_model.dart';

List<DiscoverUserModel> parseUsersInIsolate(List<dynamic> rawJsonList) {
  return rawJsonList
      .map((json) => DiscoverUserModel.fromJson(json as Map<String, dynamic>))
      .toList();
}

List<Map<String, dynamic>> generateDummyUsersInIsolate(int page) {
  final List<Map<String, dynamic>> users = [];
  final int startIndex = page * 6;

  final List<String> firstNames = [
    'Wildflower',
    'Aria',
    'Elena',
    'Maya',
    'Sophie',
    'Chloe',
    'Hannah',
    'Amelia',
    'Zoe',
    'Stella',
    'Aurora',
    'Ivy',
    'Ruby',
    'Lilith',
    'Freya',
    'Luna',
    'Serenade',
    'Calypso',
    'Nova',
    'Celeste',
    'Sienna',
    'Willow',
    'Athena',
    'Lyra',
  ];

  final List<String> bios = [
    'Professional overthinker seeking someone who analyzes text as much as me. Obsessed with iced tea and sci-fi. Low key 80s music.',
    'Architect by day, amateur chef by night. Looking for someone to share Sunday brunches and spontaneous road trips.',
    'Sunset lover & coffee enthusiast. Let’s debate the best thriller movies or go find the hidden bookstores in the city.',
    'Dog mom, yogi, and tech nerd. If you can beat me at Mario Kart, coffee is on me!',
    'Art gallery hopper and indie music fan. Looking for a genuine connection and someone who loves deep conversations.',
    'Passionate photographer seeking a muse and partner in crime. Fluent in sarcasm and movie quotes.',
  ];

  final List<List<String>> tagsPool = [
    ['Witty', 'Nerdy', 'Thoughtful'],
    ['Ambitious', 'Creative', 'Foodie'],
    ['Adventurous', 'Loyal', 'Empath'],
    ['Spontaneous', 'Bookworm', 'Chill'],
    ['Music Lover', 'Fitness', 'Optimist'],
    ['Introverted', 'Artistic', 'Deep'],
  ];

  final List<List<Map<String, String>>> interestsPool = [
    [
      {'name': 'Reading', 'icon': '🧘‍♂️'},
      {'name': 'Gym', 'icon': '🏋️‍♂️'},
      {'name': 'Movies', 'icon': '🎬'},
      {'name': 'Cricket', 'icon': '🏏'},
      {'name': 'Travel', 'icon': '✈️'},
      {'name': 'Basketball', 'icon': '🏀'},
    ],
    [
      {'name': 'Photography', 'icon': '📸'},
      {'name': 'Coffee', 'icon': '☕'},
      {'name': 'Yoga', 'icon': '🧘‍♀️'},
      {'name': 'Music', 'icon': '🎵'},
      {'name': 'Art', 'icon': '🎨'},
    ],
    [
      {'name': 'Cooking', 'icon': '🍳'},
      {'name': 'Hiking', 'icon': '🥾'},
      {'name': 'Gaming', 'icon': '🎮'},
      {'name': 'Dogs', 'icon': '🐶'},
      {'name': 'Sci-Fi', 'icon': '🛸'},
    ],
  ];

  final List<String> occupations = [
    'Product Designer',
    'Software Engineer',
    'Architect',
    'Marketing Manager',
    'Data Scientist',
    'Art Director',
  ];

  final List<String> educations = [
    'Harvard Univ',
    'Stanford Univ',
    'MIT',
    'Oxford Univ',
    'Columbia Univ',
    'UC Berkeley',
  ];

  for (int i = 0; i < 6; i++) {
    final int idx = (startIndex + i) % firstNames.length;
    final int age = 22 + (idx % 11);
    final String seedName = '${firstNames[idx]}_$startIndex$i';

    users.add({
      'id': 'user_${startIndex + i}',
      'name': firstNames[idx],
      'age': age,
      'isVerified': idx % 5 != 0,
      'profileImage': 'https://picsum.photos/seed/${seedName}_profile/600/800',
      'postImages': [
        'https://picsum.photos/seed/${seedName}_post1/600/800',
        'https://picsum.photos/seed/${seedName}_post2/600/800',
      ],
      'distanceText': '${5 + (idx % 20)} miles away',
      'distanceInMiles': 5 + (idx % 20),
      'personalityTags': tagsPool[idx % tagsPool.length],
      'isOnline': idx % 2 == 0,
      'lastSeen': 'Just now',
      'trustScore': 9.2 + ((idx % 8) * 0.1),
      'trustScoreLabel': 'Trust Score',
      'trustShieldLabel': 'Trust Shield',
      'bio': bios[idx % bios.length],
      'height': '${160 + (idx % 20)} cm',
      'weight': '${50 + (idx % 15)} kg',
      'smoking': idx % 4 == 0 ? 'Yes' : 'No',
      'drinking': idx % 3 == 0 ? 'Social Drinker' : 'No',
      'identify': 'She',
      'haveKids': 'No Kids',
      'zodiac': 'Leo',
      'workout': 'Daily',
      'interests': interestsPool[idx % interestsPool.length],
      'lookingFor': 'Ready for something serious',
      'relationshipGoal': 'Long term',
      'occupation': occupations[idx % occupations.length],
      'workplace': 'Tech Corp',
      'education': educations[idx % educations.length],
      'graduationYear': '2021',
      'languages': ['English', 'Spanish'],
      'location': 'United States',
      'city': 'New York',
      'state': 'NY',
      'country': 'United States',
      'latitude': 40.7128,
      'longitude': -74.0060,
      'isLiked': false,
      'isPassed': false,
      'isSuperLiked': false,
    });
  }

  return users;
}
