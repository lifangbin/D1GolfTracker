/// Local database of popular Australian golf courses
/// This provides course details without requiring external API calls
class CourseDatabase {
  static final List<Map<String, dynamic>> _australianCourses = [
    // NSW Courses
    {'name': 'Royal Sydney Golf Club', 'city': 'Rose Bay', 'state': 'NSW', 'par': 72, 'slope': 134, 'rating': 74.5},
    {'name': 'The Australian Golf Club', 'city': 'Rosebery', 'state': 'NSW', 'par': 71, 'slope': 138, 'rating': 75.2},
    {'name': 'NSW Golf Club', 'city': 'La Perouse', 'state': 'NSW', 'par': 72, 'slope': 136, 'rating': 74.8},
    {'name': 'Concord Golf Club', 'city': 'Concord', 'state': 'NSW', 'par': 71, 'slope': 128, 'rating': 72.5},
    {'name': 'Bonnie Doon Golf Club', 'city': 'Pagewood', 'state': 'NSW', 'par': 72, 'slope': 126, 'rating': 72.0},
    {'name': 'Elanora Country Club', 'city': 'Elanora Heights', 'state': 'NSW', 'par': 72, 'slope': 130, 'rating': 73.2},
    {'name': 'Manly Golf Club', 'city': 'Manly', 'state': 'NSW', 'par': 70, 'slope': 122, 'rating': 70.5},
    {'name': 'Terrey Hills Golf Club', 'city': 'Terrey Hills', 'state': 'NSW', 'par': 72, 'slope': 132, 'rating': 73.8},
    {'name': 'St Michaels Golf Club', 'city': 'Little Bay', 'state': 'NSW', 'par': 72, 'slope': 131, 'rating': 73.5},
    {'name': 'Long Reef Golf Club', 'city': 'Collaroy', 'state': 'NSW', 'par': 68, 'slope': 118, 'rating': 68.5},
    {'name': 'Pymble Golf Club', 'city': 'Pymble', 'state': 'NSW', 'par': 72, 'slope': 127, 'rating': 72.3},
    {'name': 'Avondale Golf Club', 'city': 'Pymble', 'state': 'NSW', 'par': 72, 'slope': 129, 'rating': 72.8},
    {'name': 'Castle Hill Country Club', 'city': 'Castle Hill', 'state': 'NSW', 'par': 72, 'slope': 125, 'rating': 71.8},
    {'name': 'Pennant Hills Golf Club', 'city': 'Beecroft', 'state': 'NSW', 'par': 72, 'slope': 128, 'rating': 72.5},
    {'name': 'The Lakes Golf Club', 'city': 'Mascot', 'state': 'NSW', 'par': 73, 'slope': 132, 'rating': 74.0},
    {'name': 'Moore Park Golf Club', 'city': 'Moore Park', 'state': 'NSW', 'par': 70, 'slope': 120, 'rating': 69.8},
    {'name': 'Carnarvon Golf Club', 'city': 'Lidcombe', 'state': 'NSW', 'par': 72, 'slope': 126, 'rating': 72.2},
    {'name': 'Bankstown Golf Club', 'city': 'Milperra', 'state': 'NSW', 'par': 72, 'slope': 129, 'rating': 73.0},
    {'name': 'Liverpool Golf Club', 'city': 'Lansvale', 'state': 'NSW', 'par': 72, 'slope': 124, 'rating': 71.5},
    {'name': 'Camden Lakeside Country Club', 'city': 'Camden', 'state': 'NSW', 'par': 72, 'slope': 128, 'rating': 72.6},

    // VIC Courses
    {'name': 'Royal Melbourne Golf Club', 'city': 'Black Rock', 'state': 'VIC', 'par': 72, 'slope': 145, 'rating': 76.5},
    {'name': 'Kingston Heath Golf Club', 'city': 'Cheltenham', 'state': 'VIC', 'par': 72, 'slope': 140, 'rating': 75.8},
    {'name': 'Victoria Golf Club', 'city': 'Cheltenham', 'state': 'VIC', 'par': 72, 'slope': 138, 'rating': 75.2},
    {'name': 'Metropolitan Golf Club', 'city': 'Oakleigh South', 'state': 'VIC', 'par': 72, 'slope': 137, 'rating': 75.0},
    {'name': 'Huntingdale Golf Club', 'city': 'Oakleigh South', 'state': 'VIC', 'par': 72, 'slope': 135, 'rating': 74.5},
    {'name': 'Yarra Yarra Golf Club', 'city': 'Bentleigh East', 'state': 'VIC', 'par': 72, 'slope': 133, 'rating': 74.0},
    {'name': 'Commonwealth Golf Club', 'city': 'Oakleigh South', 'state': 'VIC', 'par': 72, 'slope': 132, 'rating': 73.8},
    {'name': 'Peninsula Kingswood Country Golf Club', 'city': 'Frankston', 'state': 'VIC', 'par': 72, 'slope': 130, 'rating': 73.2},
    {'name': 'Woodlands Golf Club', 'city': 'Mordialloc', 'state': 'VIC', 'par': 72, 'slope': 128, 'rating': 72.8},
    {'name': 'Spring Valley Golf Club', 'city': 'Clayton', 'state': 'VIC', 'par': 72, 'slope': 127, 'rating': 72.5},

    // QLD Courses
    {'name': 'Royal Queensland Golf Club', 'city': 'Eagle Farm', 'state': 'QLD', 'par': 72, 'slope': 136, 'rating': 74.8},
    {'name': 'Brisbane Golf Club', 'city': 'Yeerongpilly', 'state': 'QLD', 'par': 72, 'slope': 130, 'rating': 73.2},
    {'name': 'Indooroopilly Golf Club', 'city': 'Indooroopilly', 'state': 'QLD', 'par': 72, 'slope': 128, 'rating': 72.8},
    {'name': 'The Brisbane Golf Club', 'city': 'Tennyson', 'state': 'QLD', 'par': 72, 'slope': 131, 'rating': 73.5},
    {'name': 'Brookwater Golf Club', 'city': 'Brookwater', 'state': 'QLD', 'par': 72, 'slope': 138, 'rating': 75.2},
    {'name': 'Sanctuary Cove Golf Club', 'city': 'Sanctuary Cove', 'state': 'QLD', 'par': 72, 'slope': 134, 'rating': 74.2},
    {'name': 'RACV Royal Pines Resort', 'city': 'Benowa', 'state': 'QLD', 'par': 72, 'slope': 132, 'rating': 73.8},
    {'name': 'Pelican Waters Golf Club', 'city': 'Pelican Waters', 'state': 'QLD', 'par': 72, 'slope': 129, 'rating': 73.0},
    {'name': 'Pacific Harbour Golf Club', 'city': 'Bribie Island', 'state': 'QLD', 'par': 72, 'slope': 127, 'rating': 72.5},
    {'name': 'Lakelands Golf Club', 'city': 'Merrimac', 'state': 'QLD', 'par': 72, 'slope': 126, 'rating': 72.2},

    // SA Courses
    {'name': 'Royal Adelaide Golf Club', 'city': 'Seaton', 'state': 'SA', 'par': 73, 'slope': 140, 'rating': 76.0},
    {'name': 'Kooyonga Golf Club', 'city': 'Lockleys', 'state': 'SA', 'par': 72, 'slope': 135, 'rating': 74.5},
    {'name': 'Glenelg Golf Club', 'city': 'Novar Gardens', 'state': 'SA', 'par': 72, 'slope': 130, 'rating': 73.2},
    {'name': 'The Grange Golf Club', 'city': 'Grange', 'state': 'SA', 'par': 72, 'slope': 132, 'rating': 73.8},
    {'name': 'Grange Golf Club West Course', 'city': 'Grange', 'state': 'SA', 'par': 72, 'slope': 128, 'rating': 72.5},

    // WA Courses
    {'name': 'Royal Perth Golf Club', 'city': 'South Perth', 'state': 'WA', 'par': 72, 'slope': 130, 'rating': 73.2},
    {'name': 'Lake Karrinyup Country Club', 'city': 'Karrinyup', 'state': 'WA', 'par': 72, 'slope': 134, 'rating': 74.2},
    {'name': 'Joondalup Resort', 'city': 'Connolly', 'state': 'WA', 'par': 72, 'slope': 132, 'rating': 73.8},
    {'name': 'The Cut Golf Course', 'city': 'Dawesville', 'state': 'WA', 'par': 72, 'slope': 136, 'rating': 74.8},
    {'name': 'Kennedy Bay Golf Club', 'city': 'Rockingham', 'state': 'WA', 'par': 72, 'slope': 128, 'rating': 72.8},

    // TAS Courses
    {'name': 'Royal Hobart Golf Club', 'city': 'Seven Mile Beach', 'state': 'TAS', 'par': 72, 'slope': 128, 'rating': 72.5},
    {'name': 'Tasmania Golf Club', 'city': 'Barilla Bay', 'state': 'TAS', 'par': 72, 'slope': 130, 'rating': 73.2},
    {'name': 'Barnbougle Dunes', 'city': 'Bridport', 'state': 'TAS', 'par': 71, 'slope': 138, 'rating': 75.0},
    {'name': 'Barnbougle Lost Farm', 'city': 'Bridport', 'state': 'TAS', 'par': 72, 'slope': 135, 'rating': 74.5},

    // ACT Courses
    {'name': 'Royal Canberra Golf Club', 'city': 'Yarralumla', 'state': 'ACT', 'par': 72, 'slope': 132, 'rating': 73.8},
    {'name': 'Federal Golf Club', 'city': 'Red Hill', 'state': 'ACT', 'par': 72, 'slope': 128, 'rating': 72.5},
    {'name': 'Yowani Country Club', 'city': 'Lyneham', 'state': 'ACT', 'par': 72, 'slope': 126, 'rating': 72.0},

    // NT Courses
    {'name': 'Darwin Golf Club', 'city': 'Marrara', 'state': 'NT', 'par': 72, 'slope': 124, 'rating': 71.5},
    {'name': 'Alice Springs Golf Club', 'city': 'Alice Springs', 'state': 'NT', 'par': 72, 'slope': 122, 'rating': 71.0},

    // Popular Junior Tour Venues
    {'name': 'Twin Creeks Golf & Country Club', 'city': 'Luddenham', 'state': 'NSW', 'par': 72, 'slope': 130, 'rating': 73.2},
    {'name': 'Stonecutters Ridge Golf Club', 'city': 'Colebee', 'state': 'NSW', 'par': 72, 'slope': 132, 'rating': 73.8},
    {'name': 'Oatlands Golf Club', 'city': 'Oatlands', 'state': 'NSW', 'par': 70, 'slope': 122, 'rating': 70.5},
    {'name': 'Cabramatta Golf Club', 'city': 'Cabramatta', 'state': 'NSW', 'par': 72, 'slope': 125, 'rating': 71.8},
    {'name': 'Marrickville Golf Club', 'city': 'Marrickville', 'state': 'NSW', 'par': 66, 'slope': 110, 'rating': 65.5},
    {'name': 'Ryde Parramatta Golf Club', 'city': 'West Ryde', 'state': 'NSW', 'par': 70, 'slope': 120, 'rating': 69.8},
    {'name': 'Wakehurst Golf Club', 'city': 'Seaforth', 'state': 'NSW', 'par': 68, 'slope': 118, 'rating': 68.2},
    {'name': 'Mona Vale Golf Club', 'city': 'Mona Vale', 'state': 'NSW', 'par': 72, 'slope': 128, 'rating': 72.5},
    {'name': 'Cromer Golf Club', 'city': 'Cromer', 'state': 'NSW', 'par': 70, 'slope': 122, 'rating': 70.2},
    {'name': 'Northbridge Golf Club', 'city': 'Northbridge', 'state': 'NSW', 'par': 69, 'slope': 119, 'rating': 69.0},
    {'name': 'Warringah Golf Club', 'city': 'North Manly', 'state': 'NSW', 'par': 70, 'slope': 121, 'rating': 70.0},
    {'name': 'Gordon Golf Club', 'city': 'Gordon', 'state': 'NSW', 'par': 68, 'slope': 116, 'rating': 67.8},
    {'name': 'Roseville Golf Club', 'city': 'Roseville', 'state': 'NSW', 'par': 70, 'slope': 120, 'rating': 69.5},
    {'name': 'Killara Golf Club', 'city': 'Killara', 'state': 'NSW', 'par': 70, 'slope': 122, 'rating': 70.2},
    {'name': 'Chatswood Golf Club', 'city': 'Chatswood', 'state': 'NSW', 'par': 70, 'slope': 118, 'rating': 69.0},
  ];

  /// Search for courses by name
  /// Returns a list of matching courses sorted by relevance
  static List<Map<String, dynamic>> searchCourses(String query) {
    if (query.trim().length < 2) return [];

    final searchTerms = query.toLowerCase().split(' ').where((s) => s.isNotEmpty).toList();

    final results = <Map<String, dynamic>>[];

    for (final course in _australianCourses) {
      final name = (course['name'] as String).toLowerCase();
      final city = (course['city'] as String).toLowerCase();

      // Check if all search terms match either name or city
      bool allMatch = true;
      int matchScore = 0;

      for (final term in searchTerms) {
        if (name.contains(term)) {
          matchScore += 2; // Higher score for name matches
        } else if (city.contains(term)) {
          matchScore += 1;
        } else {
          allMatch = false;
          break;
        }
      }

      // Also check for exact name start match (higher priority)
      if (name.startsWith(searchTerms.first)) {
        matchScore += 5;
      }

      if (allMatch) {
        results.add({...course, '_score': matchScore});
      }
    }

    // Sort by score (descending)
    results.sort((a, b) => (b['_score'] as int).compareTo(a['_score'] as int));

    // Remove score and return top 10
    return results.take(10).map((r) {
      final result = Map<String, dynamic>.from(r);
      result.remove('_score');
      return result;
    }).toList();
  }

  /// Get all courses
  static List<Map<String, dynamic>> getAllCourses() {
    return List.from(_australianCourses);
  }

  /// Get courses by state
  static List<Map<String, dynamic>> getCoursesByState(String state) {
    return _australianCourses.where((c) => c['state'] == state.toUpperCase()).toList();
  }
}
