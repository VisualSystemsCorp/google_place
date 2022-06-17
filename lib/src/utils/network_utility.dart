import 'package:google_place/google_place.dart';
import 'package:http/http.dart' as http;

/// The Network Utility
class NetworkUtility {
  static Future<String?> fetchUrl(
    Uri uri, {
    Map<String, String>? headers,
  }) async {
    try {
      final response =
          await http.get(uri, headers: headers).timeout(GooglePlace.timeout);
      if (response.statusCode == 200) {
        return response.body;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  /// Creates a uri with the proxy url if it is set
  /// [proxyUrl] Required parameters - can be formatted as [https://]host[:<port>][/<path>][?<url-param-name>=] only https proxies are supported.
  /// [authority] Required parameters - the domain name of the google server, usually https://maps.googleapis.com
  /// [unencodedGoogleMapsPath] Required parameters - the path to the api, usually something like maps/api/...
  /// [queryParameters] Required parameters - a map of query parameters to be appended to the url
  static Uri createUri(String? proxyUrl, String authority,
      String unencodedGoogleMapsPath, Map<String, String?> queryParameters) {
    final googleApiUri = Uri.https(
      authority,
      unencodedGoogleMapsPath,
      queryParameters,
    );

    var uri = googleApiUri;

    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      if (!proxyUrl.endsWith('/')) proxyUrl += '/';

      uri = Uri.parse('$proxyUrl$googleApiUri');
    }

    // print(uri.toString());
    return uri;
  }
}
