import '../models/match_model.dart';

List<MatchModel> parseMatchesInIsolate(List<dynamic> rawJsonList) {
  return rawJsonList
      .map((json) => MatchModel.fromJson(json as Map<String, dynamic>))
      .toList();
}

List<Map<String, dynamic>> generateDummyMatchesInIsolate(int page) {
  final List<Map<String, dynamic>> matches = [];
  final int startIndex = page * 8;

  final List<String> names = [
    'Wildflower',
    'Aria',
    'Elena',
    'Maya',
    'Sophie',
    'Chloe',
    'Hannah',
    'Amelia',
  ];

  final List<String> messages = [
    'Tea sounds perfect',
    'Can’t wait for our coffee date tomorrow! ☕',
    'That bookstore spot looks amazing 📚',
    'Let’s meet around 6 PM if that works for you!',
    'Haha yes, I completely agree with you 😄',
    'Thanks for the recommendation, loving it so far!',
    'Are you more into hiking or beach walks? 🌊',
    'Let me know when you reach the cafe!',
  ];

  final List<Map<String, dynamic>> defaultDateDetails = [
    {
      'whereName': 'Amber & Oak Coffee',
      'whenTime': 'Tomorrow 4:00 PM',
      'gettingThere': '12 min • Directions available',
      'matchPartnerHandle': 'GoldenHour',
      'matchPartnerAvatar': 'https://picsum.photos/seed/partner_amber/400/400',
    },
    {
      'whereName': 'The Velvet Roastery',
      'whenTime': 'Saturday 2:30 PM',
      'gettingThere': '18 min • Metro & Walk',
      'matchPartnerHandle': 'Skywalker',
      'matchPartnerAvatar': 'https://picsum.photos/seed/partner_velvet/400/400',
    },
    {
      'whereName': 'Botanical Garden Cafe',
      'whenTime': 'Sunday 11:00 AM',
      'gettingThere': '8 min • Directions available',
      'matchPartnerHandle': 'Sunflower',
      'matchPartnerAvatar': 'https://picsum.photos/seed/partner_botanical/400/400',
    },
  ];

  for (int i = 0; i < 8; i++) {
    final int idx = (startIndex + i) % names.length;
    final int age = 24 + (idx % 6);
    final String seedName = '${names[idx]}_match_$startIndex$i';
    final String partnerSeed = 'partner_${names[idx]}_$startIndex$i';
    
    // Determine status based on index to showcase all design variations
    String status = 'active';
    String remainingTime = '${43 - (i * 4)}h ${56 - (i * 7)} m';
    String? warning;
    
    if (page == 0) {
      if (i == 0) {
        status = 'active';
        remainingTime = '43h 56 m';
      } else if (i == 1) {
        status = 'expiringSoon';
        remainingTime = '43h 56 m';
        warning = 'Expiring soon: plan a date now';
      } else if (i == 2) {
        status = 'dateSet';
        remainingTime = 'Date Set';
      } else if (i == 3) {
        status = 'dateComplete';
        remainingTime = 'Date Complete';
      } else if (i == 4) {
        status = 'cancelled';
        remainingTime = 'Canceled';
      } else if (i == 5) {
        status = 'active';
        remainingTime = '28h 14 m';
      } else if (i == 6) {
        status = 'dateSet';
        remainingTime = 'Date Set';
      } else {
        status = 'dateComplete';
        remainingTime = 'Date Complete';
      }
    } else {
      final List<String> randomStatuses = ['active', 'dateSet', 'dateComplete', 'cancelled'];
      status = randomStatuses[i % randomStatuses.length];
    }

    final dateDetail = defaultDateDetails[i % defaultDateDetails.length];
    final Map<String, dynamic> customizedDateDetail = {
      ...dateDetail,
      'matchPartnerAvatar': 'https://picsum.photos/seed/$partnerSeed/400/400',
    };

    matches.add({
      'id': 'match_${startIndex + i}',
      'name': names[idx],
      'age': age,
      'profileImage': 'https://picsum.photos/seed/$seedName/500/500',
      'lastMessage': messages[idx % messages.length],
      'status': status,
      'remainingTimeText': remainingTime,
      'warningText': warning,
      'dateDetails': customizedDateDetail,
      'isOnline': i % 2 == 0,
      'trustScore': 9.2 + ((idx % 7) * 0.1),
      'bio': 'Coffee lover, spontaneous road tripper, and amateur photographer. Let’s beat the clock and plan a real date!',
    });
  }

  return matches;
}
