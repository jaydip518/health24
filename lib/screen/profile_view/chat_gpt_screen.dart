import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';

import '../../model/message_model.dart';


class ChatGptScreen extends StatefulWidget {
  const ChatGptScreen({super.key});

  @override
  State<ChatGptScreen> createState() => _ChatGptScreenState();
}

class _ChatGptScreenState extends State<ChatGptScreen> {
  TextEditingController messageController = TextEditingController();
  List<MessageModel> messageList = [];
  bool inProgress = false;

  //initialize openai
  final openAI = OpenAI.instance.build(
      token: "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",
      baseOption: HttpSetup(receiveTimeout: 30000),isLogger: true);

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade400,
        title: const Text("Chat With Doctor"),centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: messageList.isEmpty
                  ? const Center(
                child: Text(
                  "How can i help you?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontFamily: 'monospace'),
                ),
              )
                  : buildMessageListWidget()),
          if (inProgress)
            const LinearProgressIndicator(
              minHeight: 2,
            ),
          buildSendWidget(),
        ],
      ),
    );
  }

  Widget buildMessageListWidget() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return buildSingleMessageRow(messageList[index]);
      },
      reverse: true,
      itemCount: messageList.length,
    );
  }

  Widget buildSingleMessageRow(MessageModel messageModel) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Align(
        alignment:
        messageModel.sentByMe ? Alignment.topRight : Alignment.topLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 30,
              width: 60,
              child: messageModel.sentByMe
                  ? Center(child: Text("User"))
                  : Center(child: Text("Docter")),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: messageModel.sentByMe
                        ? Colors.deepOrange[300]
                        : Colors.teal.shade400,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    messageModel.message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSendWidget() {
    return Container(
      color: Colors.white,
      height: 60,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: messageController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black),
                  hintText: "Message",
                  border: InputBorder.none,
                ),
              )),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            backgroundColor: Colors.teal.shade400,
            onPressed: () {
              String question = messageController.text.toString();
              if (question.isEmpty) return;
              messageController.clear();
              addMessageToMessageList(question, true);
              sendMessageToAPI(question);
            },
            elevation: 0,
            child: const Icon(
              Icons.send,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void sendMessageToAPI(String question) async {
    //send to OPENAI API

    setState(() {
      inProgress = true;
    });

    final request = CompleteText(
      prompt: question,
      model: kTranslateModelV3,
      maxTokens: 4000,
    );
    try {
      final response = await openAI.onCompleteText(request: request);
      print(response);
      String answer = response?.choices.last.text.trim() ?? "";
      addMessageToMessageList(answer, false);
    } catch (e) {
      addMessageToMessageList("Failed to get response please try again", false);
    }

    setState(() {
      inProgress = false;
    });
  }

  void addMessageToMessageList(String message, bool sentByMe) {
    setState(() {
      messageList.insert(0, MessageModel(message: message, sentByMe: sentByMe));
    });
  }
}
