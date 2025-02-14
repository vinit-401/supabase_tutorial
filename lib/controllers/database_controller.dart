import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class Controller{

  static late final SupabaseClient supabase;

  static init(SupabaseClient client){
    supabase = client;
  }
  static Future<void> insertData(Map<String, dynamic> data) async{
    try{
      dynamic res = await supabase.from('person').insert(data);
      if(res == null){
        print('success');
      }
    }
    catch(e){
      print(e);
      print('error');
    }
  }

  static Future<void> uploadProfilePicture(String filePath) async{
    final avatarFile = File(filePath);
    // final String fullPath = await supabase.storage.from('personBucket').upload(
    //   'personBucket/user.png',
    //   avatarFile,
    // );
    final String path = await supabase.storage.from('personBucket').update(
      'personBucket/user.png',
      avatarFile,
    );

  }
}