import '../../app/app_typedefs.dart';

class JsonMapper {
  int? mapToNullableInt(JsonMap jsonMap, String key) {
    final value = jsonMap[key];

    if (value == null) {
      return null;
    } else {
      return mapToInt(jsonMap, key);
    }
  }

  int mapToInt(JsonMap jsonMap, String key) {
    final value = jsonMap[key];

    if (value == null) {
      throw Exception("The required key $key not found");
    }

    try {
      return value;
    } catch (_) {
      throw Exception("The key: $key, value: $value => value is not an int");
    }
  }

  String? mapToNullableString(JsonMap jsonMap, String key) {
    final value = jsonMap[key];

    if (value == null) {
      return null;
    } else {
      return mapToString(jsonMap, key);
    }
  }

  String mapToString(JsonMap jsonMap, String key) {
    final value = jsonMap[key];

    if (value == null) {
      throw Exception("The required key $key not found");
    }

    try {
      return value;
    } catch (_) {
      throw Exception("The key: $key, value: $value => value is not a String");
    }
  }

  List<JsonMap>? mapToNullableJsonList(JsonMap jsonMap, String key) {
    final value = jsonMap[key];

    if (value == null) {
      return null;
    } else {
      return mapJsonList(jsonMap, key);
    }
  }

  List<JsonMap> mapJsonList(JsonMap jsonMap, String key) {
    try {
      final value = jsonMap[key] as List?;

      if (value == null) {
        throw Exception("The required key $key not found");
      }

      return value.cast<JsonMap>();
    } catch (_) {
      throw Exception("The key: $key, value: ${jsonMap[key]} => value is not a List<JsonMap>");
    }
  }

  bool mapToBool(JsonMap jsonMap, String key) {
    final value = jsonMap[key];

    if (value == null) {
      throw Exception("The required key $key not found");
    }

    try {
      return value;
    } catch (_) {
      throw Exception("The key: $key, value: $value => value is not a bool");
    }
  }
}
