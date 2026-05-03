import 'package:advice_generator_app/models/advice_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AdviceService{
final String _baseurl = 'https://api.adviceslip.com/advice';

Future<AdviceController> searchNewAdvice() async {
  final response = await http.get(Uri.parse(_baseurl));

  if(response.statusCode == 200){
    return AdviceController.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Load error');
  }

}

  
  
  
}