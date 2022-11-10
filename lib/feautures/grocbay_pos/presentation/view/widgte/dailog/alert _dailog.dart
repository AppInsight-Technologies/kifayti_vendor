import 'package:awesome_dialog/awesome_dialog.dart';

class Alert {
  AwesomeDialog showallert(context,{String? messege,Function()? onpress,Function()? onpresscancel}){
   return AwesomeDialog(
     autoDismiss: true,
     dismissOnTouchOutside: true,
     dismissOnBackKeyPress: true,
      context: context,
      width: 400,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: messege,
     btnCancelOnPress: () =>onpresscancel!(),
     btnOkOnPress: () =>onpress!(),
    )..show();
  }
  showSuccess(context,{String? messege, }){
    return AwesomeDialog(
      // autoDismiss: true,
      // dismissOnTouchOutside: true,
      // dismissOnBackKeyPress: true,
      context: context,
      width: 400,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: messege,
      //  btnCancelOnPress: () =>onpresscancel!(),
      // btnOkOnPress: () =>onpress!(),
    )..show();
  }
  showError(){

  }
}