class AppApiConfig {
  ///Stagging
  //static const scheme = "http";
  //static const host = "wp.jithvar.com";

  ///Live endpoint
  static const scheme = "https";
  static const host = "gmaps-places-api.onrender.com";
  //static const _version = "/dev/chat";

  static const newscheme = "https";
  static const newhost = "tourist-attraction-api.onrender.com";

  static Uri _appUri(String endpoint, [Map<String, String>? query]) {
    return Uri(
      scheme: scheme,
      host: host,
      path: endpoint,
      queryParameters: query,
    );
  }

  static Uri _newAppUri(String newendpoint, [Map<String, String>? newquery]) {
    return Uri(
      scheme: newscheme,
      host: newhost,
      path: newendpoint,
      queryParameters: newquery,
    );
  }

  static Uri nearbyPlacesUri({
    required String lat,
    required String long,
    required String type,
  }) {
    return _appUri(
        "/places", {'latitude': lat, 'longitude': long, 'type': type});
  }

  static Uri placeUri(String placeId) {
    return _appUri("places/$placeId");
  }

  static Uri getNewPlaces() {
    return _newAppUri("/places/textsearch");
  }

  static Uri getbyType() {
    return _newAppUri("/places/type_search");
  }

  static Uri getbyKeyword() {
    return _newAppUri("/places/keyword_search");
  }

  /* static Uri getAllContactMessages() {
    return _appUri(
      "/api/contacts",
      {
        "order_by": "latest_message_time",
        "order_direction": "desc",
        "has_messages": "true"
      },
    );
  }

  static Uri getUnreadContactMessages() {
    return _appUri(
      "/api/contacts",
      {
        "order_by": "latest_message_time",
        "order_direction": "desc",
        "has_unread_messages": "true"
      },
    );
  }

  static Uri getReadContactMessages() {
    return _appUri("/api/contacts", {
      "order_by": "latest_message_time",
      "order_direction": "desc",
      "has_unread_messages": "false"
    });
  }

  static Uri getMessagesForContact(String phoneNumber) {
    return _appUri("/api/messages", {
      "order_by": "created_at",
      "order_direction": "asc",
      "phone_number": phoneNumber,
    });
  }

  static Uri sendMessageUri() {
    return _appUri("/api/chats");
  }

  static Uri uploadImageUri() {
    return _appUri("/api/message-media");
  }

  static Uri sendImageMessageUri() {
    return _appUri("/api/chats-test");
  }

  static Uri userProfileUri() {
    return _appUri("/api/user");
  }*/
}
