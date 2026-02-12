import 'package:elf_server/src/services/geminiService.dart';
import 'package:serverpod/serverpod.dart';


/// Endpoint for AI chat functionality
class ChatEndpoint extends Endpoint {
  /// Sends a message to Gemini and returns the AI response
  Future<String> sendMessage(Session session, String message) async {
    try {
      // Validate input
      if (message.trim().isEmpty) {
        throw Exception('Message cannot be empty');
      }

      // Log incoming message (truncated for privacy)
      final preview = message.length > 50 
          ? '${message.substring(0, 50)}...' 
          : message;
      session.log('Chat message received: $preview');

      // Get API key from passwords.yaml
      final apiKey = session.passwords['geminiApiKey'];
      
      if (apiKey == null || apiKey.isEmpty) {
        session.log(
          'Gemini API key not found in passwords.yaml',
          level: LogLevel.error,
        );
        throw Exception('Gemini API key not configured');
      }

      // Call Gemini service
      final geminiService = GeminiService(apiKey: apiKey);
      final response = await geminiService.generateContent(message);

      session.log('AI response generated successfully');
      return response;

    } catch (e, stackTrace) {
      session.log(
        'Error in sendMessage: $e',
        level: LogLevel.error,
      );
      session.log(
        'Stack trace: $stackTrace',
        level: LogLevel.error,
      );
      
      // Re-throw configuration errors
      if (e.toString().contains('API key') || 
          e.toString().contains('configured')) {
        rethrow;
      }
      
      // User-friendly error for other cases
      throw Exception('Failed to generate AI response. Please try again.');
    }
  }
}