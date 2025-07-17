import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/show_category.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/services/show_category_news.dart';

class CategoryNews extends StatefulWidget {
String name;
CategoryNews({required this.name});
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}


class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories=[];
bool _loading = true;

@override
void initState() {
  super.initState();
  getNews();
  
}

getNews()async{
 ShowCategoryNews showCategoryNews = ShowCategoryNews();
 await showCategoryNews.getCategoryNews(widget.name.toLowerCase());
 categories =    showCategoryNews.categories;
 setState(() {
   _loading = false;
 });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title:
          Text(widget.name,style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),

        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child:  ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: categories.length,
                    itemBuilder: (context, index){
                      return ShowCategory(
                        Image: categories[index].urlToImage!,
                        desc: categories[index].description!,
                        title: categories[index].title!,
                        url: categories[index].url!,
                       );
                    }),
      )
    );
  }
}
class ShowCategory extends StatelessWidget {
String Image, desc, title,url;
ShowCategory({required this.desc,required this.url, required this.Image, required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(imageUrl: Image,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5,),
            Text(title,maxLines: 2, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
            Text(desc,maxLines: 3, style: TextStyle(color: Colors.black38, fontSize: 16, fontWeight: FontWeight.w500),),
            SizedBox(height: 20,)
      
          ],
        ),    
      ),
    );
  }
}