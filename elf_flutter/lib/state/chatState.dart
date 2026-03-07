
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:elf_client/elf_client.dart';
import 'package:elf_flutter/main.dart';


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


enum MessageRole {
  user,
  assistant,
  system,
}

enum MessageType {
  normal,
  typing,
}


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
    final String id;
  final String text;
  final MessageRole role;
  final MessageType type;
  final DateTime timestamp;
  bool isTypingComplete;

  // 🔥 Future interaction states
  final bool? isLiked;        // null = not voted
  final bool isCopied;
  final bool isRegenerating;
  final bool hasError;


  ChatMessage({
    required this.id,
    required this.text,
    required this.role,
    this.type = MessageType.normal,
    DateTime? timestamp,
    this.isLiked,
    this.isTypingComplete = false,
    this.isCopied = false,
    this.isRegenerating = false,
    this.hasError = false,
  }) : timestamp = timestamp ?? DateTime.now();

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
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  text: userMessage.trim(),
  role: MessageRole.user,
);

  final typingMsg = ChatMessage(
  id: 'typing',
  text: '',
  role: MessageRole.assistant,
  type: MessageType.typing,
);
    
    state = state.copyWith(
      messages: [typingMsg, userMsg, ...state.messages],
      isLoading: true,
      error: null,
    );

  

    try {
      // Call Serverpod endpoint
    final aiResponse = await client.chat.sendMessage(userMessage);

// remove typing message
final updatedMessages = [...state.messages];
updatedMessages.removeWhere((m) => m.type == MessageType.typing);

final aiMsg = ChatMessage(
  id: DateTime.now().millisecondsSinceEpoch.toString(),
  text: aiResponse,
  role: MessageRole.assistant,
  isTypingComplete: false,
);

state = state.copyWith(
  messages: [aiMsg, ...updatedMessages],
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
          id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: 'Sorry, I encountered an error: $errorMessage',
        role: MessageRole.system
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