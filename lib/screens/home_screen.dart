import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tutorial/app/app_color.dart';
import 'package:supabase_tutorial/app/input_decoration.dart';
import 'package:supabase_tutorial/app/validators.dart';
import 'package:supabase_tutorial/controllers/database_controller.dart';

GlobalKey<FormState> _formKey = GlobalKey();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime? selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }
  @override
  void deactivate() {
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _phoneController.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhite,
      appBar: AppBar(
        backgroundColor: AppColor.kWhite,
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 15,
              children: [
                profilePhotoView(context),
                SizedBox(
                  height: 15,
                ),
                // userData(context),
                userDataView(context),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Controller.insertData({
                        'user_name':_nameController.text.trim(),
                        'user_email':_emailController.text.trim(),
                        'user_dob': _dateController.text.trim(),
                        'user_phone':_phoneController.text.trim(),
                      });

                    }
                    FocusScope.of(context).unfocus();
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: () async{
      //       // Controller.insertData({'user_name':"name",'user_email':'email@gmail.com','user_phone':1231231230,'user_dob':'2025-02-12'});
      // },),
    );
  }

  Widget profilePhotoView(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: MediaQuery.sizeOf(context).width * 0.2,
              child: Image.network(
                '',
                errorBuilder: (context, error, stackTrace) {
                  return Container();
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 15,
          right: MediaQuery.sizeOf(context).width * 0.25,
          child: IconButton(
            onPressed: () async {
              FilePickerResult? file = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);
              print("Path: ${file!.files.first.path}");
              Controller.uploadProfilePicture(file!.files.first.path!);
            },
            icon: Icon(Icons.edit),
            color: Colors.white,
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  Widget userDataView(BuildContext context) {
    return Column(
      spacing: 18,
      children: [
        TextFormField(
          validator: (value) => nameValidator(value),
          controller: _nameController,
          decoration: inputDecoration('Name'),
        ),
        TextFormField(
          validator: (value) => emailValidator(value),
          controller: _emailController,
          decoration: inputDecoration('Email'),
        ),
        TextFormField(
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
            // TextInputFormatter.withFunction(
            //   (oldValue, newValue) {
            //     var text = newValue.text;
            //
            //     if (newValue.selection.baseOffset == 0) {
            //       return newValue;
            //     }
            //
            //     var buffer = new StringBuffer();
            //     for (int i = 0; i < text.length; i++) {
            //       buffer.write(text[i]);
            //       var nonZeroIndex = i + 1;
            //       if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
            //         buffer.write(' '); // Replace this with anything you want to put after each 4 numbers
            //       }
            //     }
            //
            //     var string = buffer.toString();
            //     return newValue.copyWith(text: string, selection: new TextSelection.collapsed(offset: string.length));
            //   },
            // )
          ],
          validator: (value) => phoneValidator(value),
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: inputDecoration('Phone'),
        ),
        TextFormField(
          readOnly: true,
          validator: (value) => dobValidator(value),
          onTap: ()async {
            final DateTime? pickedDate=await showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
            setState(() {
              selectedDate = pickedDate;
              _dateController.text=  selectedDate != null
                  ? '${selectedDate!.year}/${selectedDate!.month}/${selectedDate!.day}'
                  : 'No date selected';
            });
          },
          controller: _dateController,
          decoration: inputDecoration('Date Of Birth'),
        ),
      ],
    );
  }
}
