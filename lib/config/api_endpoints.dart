import '../features/auth_mod/auth_app.dart';

/// In this file we will be writing all API Endpoints using this application

class ApiEndpoint {
  // News Server
  static const rapidUrl = 'https://free-news.p.rapidapi.com';
  static const news = rapidUrl + '/v1/search';

  // Server Links
  static const baseUrl = 'https://apps.shibajidebnath.com/';
  static const api = baseUrl + 'api/';

  // Enqueries Endpoints
  static const enqueries = api + 'enqueries?populate=*&sort[0]=id%3Adesc';
  static const enquery = api + 'enqueries';

  // Apps Internals Links
  static const appLoginUrl = AuthApp.login;
  static const appRegiaterUrl = AuthApp.register;
  static const appForgetUrl = AuthApp.forget;
  static const appProfileUrl = AuthApp.profile;
}
