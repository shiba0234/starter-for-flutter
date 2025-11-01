import 'package:appwrite/appwrite.dart';
import '../constants/appwrite_constants.dart';

class AppwriteProviders {
  static final AppwriteProviders _instance = AppwriteProviders._internal();

  factory AppwriteProviders() {
    return _instance;
  }

  AppwriteProviders._internal();

  late Client client;
  late Account account;
  late Databases databases;
  late Storage storage;
  late Realtime realtime;

  void initialize() {
    client = Client()
        .setEndpoint(AppwriteConstants.appwritePublicEndpoint)
        .setProject(AppwriteConstants.appwriteProjectId)
        .setSelfSigned(
            status: true); // Only for development with self-signed certificates

    account = Account(client);
    databases = Databases(client);
    storage = Storage(client);
    realtime = Realtime(client);
  }
}
