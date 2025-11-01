import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../core/providers/appwrite_providers.dart';
import '../core/constants/appwrite_constants.dart';

class DatabaseService {
  final Databases _databases = AppwriteProviders().databases;

  // Create document
  Future<models.Document> createDocument({
    required String collectionId,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: collectionId,
        documentId: ID.unique(),
        data: data,
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Failed to create document';
    }
  }

  // Get document
  Future<models.Document> getDocument({
    required String collectionId,
    required String documentId,
  }) async {
    try {
      return await _databases.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Failed to fetch document';
    }
  }

  // List documents
  Future<models.DocumentList> listDocuments({
    required String collectionId,
    List<String>? queries,
  }) async {
    try {
      return await _databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: collectionId,
        queries: queries,
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Failed to fetch documents';
    }
  }

  // Update document
  Future<models.Document> updateDocument({
    required String collectionId,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      return await _databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: collectionId,
        documentId: documentId,
        data: data,
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Failed to update document';
    }
  }

  // Delete document
  Future<void> deleteDocument({
    required String collectionId,
    required String documentId,
  }) async {
    try {
      await _databases.deleteDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: collectionId,
        documentId: documentId,
      );
    } on AppwriteException catch (e) {
      throw e.message ?? 'Failed to delete document';
    }
  }
}
