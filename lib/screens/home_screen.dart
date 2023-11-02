import 'package:chat_application_it/shared/cubits/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getRecentlyChats();
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme
                    .of(context)
                    .scaffoldBackgroundColor,
                title: const Text(
                  'Recently Chats',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  IconButton(
                    onPressed: () {

                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.black,
                    ),
                  ),
                ],
                elevation: 0.0,
              ),
              body:state is GetRecentChatsError ? const Center(
                child: Text(
                  'Try Again Later',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24.0
                  ),
                ),
              ): Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.separated(
                    itemBuilder: (context,index){
                      int day = cubit.recentUsers[index].lastMessage!.time.toDate().day;
                      int year = cubit.recentUsers[index].lastMessage!.time.toDate().year;
                      int month = cubit.recentUsers[index].lastMessage!.time.toDate().month;

                      int hour = cubit.recentUsers[index].lastMessage!.time.toDate().hour;
                      int minute = cubit.recentUsers[index].lastMessage!.time.toDate().hour;

                      return Card(
                        child:
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      cubit.recentUsers[index].imgLink,
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: cubit.recentUsers[index].online?Colors.green:Colors.red
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 15.0,
                              ),
                              Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        cubit.recentUsers[index].name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        cubit
                                            .recentUsers[index]
                                            .lastMessage!.senderId == cubit.user!.userId ? 'You:${cubit.recentUsers[index].lastMessage!.content}':
                                            '${cubit
                                                .recentUsers[index].name}: ${cubit.recentUsers[index].lastMessage!.content}',
                                        style: const TextStyle(
                                          color: Colors.blueGrey,
                                          fontSize: 16.0,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '$day/$month/$year',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 13.0
                                    ),
                                  ),
                                  Text(
                                    '$hour:$minute',
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 13.0
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  separatorBuilder: (context,index){
                      return const SizedBox(
                        height: 10.0,
                      );
                  },
                  itemCount: cubit.recentUsers.length,
                ),
              ),
            );
          },
        );
      }
    );
  }
}
