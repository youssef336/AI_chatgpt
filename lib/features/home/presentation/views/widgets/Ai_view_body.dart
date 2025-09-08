// ignore_for_file: file_names

import 'dart:convert'; // for jsonEncode/jsonDecode
import 'package:ai_gpt/core/widgets/ChatBuble.dart';
import 'package:ai_gpt/core/widgets/custom_text_feild.dart';

import 'package:flutter/material.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _saveMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(_messages); // convert to String
    await prefs.setString('chat_history', encoded);
  }

  Future<void> _loadMessages() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString('chat_history');
    if (stored != null) {
      final decoded = List<Map<String, dynamic>>.from(jsonDecode(stored));
      setState(() {
        _messages.clear();
        _messages.addAll(
          decoded.map(
            (e) => {"role": e["role"].toString(), "text": e["text"].toString()},
          ),
        );
      });
    }
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add({"role": "user", "text": text});
      _isLoading = true;
      _controller.clear();
    });
    _scrollToBottom();
    _saveMessages();

    try {
      final model = FirebaseAI.googleAI().generativeModel(
        model: 'gemini-2.5-flash',
      );

      final prompt = [Content.text(text)];
      final response = await model.generateContent(prompt);

      setState(() {
        _messages.add({"role": "ai", "text": response.text ?? "No response"});
      });
      _scrollToBottom();
      _saveMessages();
    } catch (e) {
      setState(() {
        _messages.add({"role": "ai", "text": "Error: $e"});
      });
      _scrollToBottom();
      _saveMessages();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Chat"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('chat_history');
              setState(() => _messages.clear());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                if (msg["role"] == "user") {
                  return ChatBubleForFreind(message: msg["text"]!);
                } else {
                  return ChatBuble(message: msg["text"]!);
                }
              },
            ),
          ),

          // Input
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormFeild(
                    controller: _controller,
                    hintText: "Ask AI something...",
                    textInputType: TextInputType.text,
                    maxLines: 1,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: _isLoading ? null : _sendMessage,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
