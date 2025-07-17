import 'dart:convert';

import 'package:news_app/models/article_model.dart';
import 'package:http/http.dart'as http;
class News{
List<ArticleModel> news=[];

Future<void> getNews()async{
 String url ="https://newsapi.org/v2/everything?q=tesla&from=2025-06-17&sortBy=publishedAt&apiKey=5fe8719fdcd54eb08ee2db8faea4b5d5";

var response = await http.get(Uri.parse(url));
    print("Status Code: ${response.statusCode}");

var jsonData = jsonDecode(response.body);
if(jsonData['status']=='ok'){
      print("Total articles received: ${jsonData['articles'].length}");

 jsonData["articles"].forEach((element){
   if(element["urlToImage"]!=null && element["description"]!=null  && element["title"] != null &&
            element["url"] != null){
   ArticleModel articleModel = ArticleModel(
      title: element["title"],
      description: element["description"],
      url: element["url"],
      urlToImage: element["urlToImage"],
      content: element["content"],
      author: element["author"],
   );
   news.add(articleModel);
 }
 });

      print("Articles after filtering: ${news.length}");

}else {
    print("API Error: ${jsonData['message']}");
}
}
}