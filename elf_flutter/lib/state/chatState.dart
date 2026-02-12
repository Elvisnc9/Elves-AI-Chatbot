
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elf_client/elf_client.dart';
import 'package:elf_flutter/main.dart';

// ==================== CLIENT PROVIDER ====================

/// Serverpod client instance
/// Update URL based on your environment:
/// - Emulator: 'http://10.0.2.2:8080/'
/// - iOS Simulator: 'http://localhost:8080/'
/// - Physical device: 'http://YOUR_IP:8080/'
final clientProvider = Provider<Client>((ref) {
  return client;
});

// Simple session manager (no auth in Ghost Mode)
class SessionManager extends AuthenticationKeyManager {
  @override
  Future<String?> get() async => null;

  @override
  Future<void> put(String key) async {}

  @override
  Future<void> remove() async {}

  @override
  Future<String?> toHeaderValue(String? key) async {
    // Return null or the header value as needed for your use case
    return null;
  }
}

// ==================== CHAT STATE MODEL ====================

class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// ==================== CHAT MESSAGE MODEL ====================

class ChatMessage {
  final String text;
  final bool isMe;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isMe,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() => 'ChatMessage(isMe: $isMe, text: ${text.substring(0, text.length > 30 ? 30 : text.length)}...)';
}

// ==================== CHAT NOTIFIER ====================

class ChatNotifier extends StateNotifier<ChatState> {
  final Client client;

  ChatNotifier(this.client) : super(const ChatState());

  /// Send a message to the AI and add both messages to the list
  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    // Add user message immediately
    final userMsg = ChatMessage(
      text: userMessage.trim(),
      isMe: true,
    );
    
    state = state.copyWith(
      messages: [userMsg, ...state.messages],
      isLoading: true,
      error: null,
    );

    try {
      // Call Serverpod endpoint
      final aiResponse = await client.chat.sendMessage(userMessage);

      // Add AI response
      final aiMsg = ChatMessage(
        text: aiResponse,
        isMe: false,
      );
      
      state = state.copyWith(
        messages: [aiMsg, ...state.messages],
        isLoading: false,
      );
      
    } catch (e) {
      // Handle error
      final errorMessage = e.toString().replaceAll('Exception: ', '');
      
      state = state.copyWith(
        isLoading: false,
        error: errorMessage,
      );
      
      // Add error message to chat
      final errorMsg = ChatMessage(
        text: 'Sorry, I encountered an error: $errorMessage',
        isMe: false,
      );
      
      state = state.copyWith(
        messages: [errorMsg, ...state.messages],
      );
    }
  }

  /// Clear all messages (start new chat)
  void clearChat() {
    state = const ChatState();
  }

  /// Clear error state
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// Get message count
  int get messageCount => state.messages.length;

  /// Check if chat is empty
  bool get isEmpty => state.messages.isEmpty;
}

// ==================== PROVIDER ====================

/// Main chat provider - use this in your UI
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  final client = ref.watch(clientProvider);
  return ChatNotifier(client);
});