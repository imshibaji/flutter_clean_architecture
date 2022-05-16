import '../features/features.dart';

/// In this file we will be writing all API Endpoints using this application

class ApiEndpoint {
  // Server Links
  static const baseUrl = 'https://apps.shibajidebnath.com/';
  static const api = baseUrl + 'api/';

  static const enqueries = api + 'enqueries?populate=*';

  // Apps Internals Links
  static const appLoginUrl = AuthApp.login;
}
