import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:news_app/models/slider_model.dart';

class Sliders{
List<sliderModel> sliders=[];

Future<void> getSlider()async{
 String url ="https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=5fe8719fdcd54eb08ee2db8faea4b5d5";

var response = await http.get(Uri.parse(url));
    print("Status Code: ${response.statusCode}");

var jsonData = jsonDecode(response.body);
if(jsonData['status']=='ok'){
      print("Total articles received: ${jsonData['articles'].length}");

 jsonData["articles"].forEach((element){
   if(element["urlToImage"]!=null && element["description"]!=null  && element["title"] != null &&
            element["url"] != null){
   sliderModel slidermodel = sliderModel(
      title: element["title"],
      description: element["description"],
      url: element["url"],
      urlToImage: element["urlToImage"],
      content: element["content"],
      author: element["author"],
   );
   sliders.add(slidermodel);
 }
 });

      print("Articles after filtering: ${sliders.length}");

}else {
    print("API Error: ${jsonData['message']}");
}
}
}