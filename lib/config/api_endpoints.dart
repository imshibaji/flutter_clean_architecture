import '../features/features.dart';

/// In this file we will be writing all API Endpoints using this application

class ApiEndpoint {
  // News Server
  static const rapidUrl = 'https://free-news.p.rapidapi.com';

  static const news = rapidUrl + '/v1/search';

  // Server Links
  static const baseUrl = 'https://apps.shibajidebnath.com/';
  static const api = baseUrl + 'api/';

  static const enqueries = api + 'enqueries?populate=*';

  // Apps Internals Links
  static const appLoginUrl = AuthApp.login;
}
