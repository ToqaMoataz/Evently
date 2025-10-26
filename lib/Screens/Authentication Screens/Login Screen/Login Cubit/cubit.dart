import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:evently/Core/routes/routes.dart';
import 'package:evently/Screens/Authentication%20Screens/Login%20Screen/Login%20Cubit/states.dart';

import '../../../../Firebase/firebase_manager.dart';

class LoginCubit extends Cubit<LoginStates>{
 LoginCubit() : super(LoginInitState());

 static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

 Future<void> login(String email,String password,context) async {
   try{
     await FirebaseManager.signin(
       email:email,
       password:password,
       onSucess: (){
         Navigator.pushReplacementNamed(context, Routes.homeScreenRouteName);
       },
       onFail: (String errorMessage) {
         showDialog(
           context: context,
           builder: (context) => AlertDialog(
             title: Text("Signup Failed"),
             content: Text(errorMessage),
             actions: [
               TextButton(
                 child: Text("OK"),
                 onPressed: () => Navigator.pop(context),
               ),
             ],
           ),
         );
       },
     );
   }catch(e){

   }
 }
}