
import 'package:flutter/material.dart';

class TextFields{
  static List textControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  static Padding punishmentField ({required TextEditingController controller, required int num ,required ValueChanged<String>? onChanged}){
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: onChanged,
        textInputAction: TextInputAction.next,
        controller: controller,
        decoration:  InputDecoration(
          labelText: '罰ゲーム  その${num.toString()}',
          hintText: '内容を入力してください。',
          labelStyle: const TextStyle(color: Colors.grey),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}