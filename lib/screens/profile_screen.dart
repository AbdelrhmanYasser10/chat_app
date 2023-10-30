import 'dart:io';

import 'package:chat_application_it/shared/cubits/app_cubit/app_cubit.dart';
import 'package:chat_application_it/shared/widgets/my_button/my_button.dart';
import 'package:chat_application_it/shared/widgets/my_form_field/my_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if(state is GetImageSuccefully){
          AppCubit.get(context).cropImage();
        }
        if(state is UserEditDataError){
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Error while updating")));
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      state is CroppedSuccessfully ?CircleAvatar(
                        radius: 55.0,
                        backgroundImage: FileImage(
                          File(
                              cubit.finalImage!.path,
                          ),
                        ),
                      ):state is UserEditDataLoading ? const Center(
                        child: CircularProgressIndicator(),
                      ):CircleAvatar(
                        radius: 55.0,
                        backgroundImage: NetworkImage(
                          cubit.user!.imgLink,
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          cubit.getImage();
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueAccent,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyFormField(
                                controller: _nameController..text = cubit.user!.name,
                                text: cubit.user!.name,
                                validator: (value){
                                    if(value!.isEmpty){
                                      return "Name must not be empty";
                                    }
                                    return null;
                                },
                                prefixIcon: const Icon(
                                  Icons.person,
                                ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  state is UserEditDataLoading ? const Center(
                    child: LinearProgressIndicator(),
                  ):MyButton(
                      text: "Update Data",
                      onTap: (){
                        if(_formKey.currentState!.validate()){
                          cubit.updateUserData(name: _nameController.text);
                        }
                      },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
