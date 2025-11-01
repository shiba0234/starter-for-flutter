class AppwriteConstants {
  static const String appwriteProjectId = '6905cda2003c1d3ada33';
  static const String appwriteProjectName = 'dsdasdasd';
  static const String appwritePublicEndpoint =
      'https://sgp.cloud.appwrite.io/v1';
  static const String databaseId = '6905fe85002679080b69';
  static const String collectionId = '6905fe85002679080b69';
  static const String googleOAuthProvider = 'google';
  static String get successUrl => '$appwritePublicEndpoint/auth/oauth/success';
  static String get failureUrl => '$appwritePublicEndpoint/auth/oauth/failure';
}
