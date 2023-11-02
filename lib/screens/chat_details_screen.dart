import 'package:chat_application_it/models/user_model.dart';
import 'package:chat_application_it/shared/cubits/app_cubit/app_cubit.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatefulWidget {
  final UserModel receiver;
  const ChatDetailsScreen({Key? key, required this.receiver}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder:(context){
        AppCubit.get(context).getMessages(widget.receiver.userId);
        AppCubit.get(context).checkUserOnline(widget.receiver.userId);
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: Row(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 24.0,
                          backgroundImage: NetworkImage(
                            widget.receiver.imgLink,
                          ),
                        ),
                        CircleAvatar(
                          radius: 5.0,
                          backgroundColor:
                          cubit.isReceiverOnline == null ? Colors.red : cubit.isReceiverOnline! ?Colors.green : Colors.red,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      widget.receiver.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  ),
                ),
                elevation: 0.0,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index){
                        bool isSender = (widget.receiver.userId != cubit.messages[index].senderId);
                        return BubbleSpecialThree(
                          text: cubit.messages[index].content,
                          color: isSender?Colors.blueAccent:Colors.black,
                          tail: false,
                          isSender: isSender,
                          textStyle: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                      separatorBuilder: (context,index){
                        return const SizedBox(
                          height: 10.0,
                        );
                      },
                      itemCount: cubit.messages.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: _fromKey,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                filled: true,
                                hintText: "Type your message...",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Don't enter empty message";
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              if(_fromKey.currentState!.validate()){
                                cubit.sendMessage(
                                  receiverId: widget.receiver.userId,
                                  content: _messageController.text,
                                );
                                _messageController.clear();
                              }
                              else{
                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Message must not be empty',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: const Icon(
                              Icons.send,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }
}
