import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article_model.dart';
import 'package:news_app/models/category_model.dart';
import 'package:news_app/models/slider_model.dart';
import 'package:news_app/pages/all_news.dart';
import 'package:news_app/pages/article_view.dart';
import 'package:news_app/pages/category_news.dart';
import 'package:news_app/services/data.dart';
import 'package:news_app/services/news.dart';
import 'package:news_app/services/slider_data.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 List<CategoryModel> categories= [];
  List<sliderModel> sliders= [];
  List<ArticleModel> articles =[];
  bool _loading = true;
  int activeIndex= 0;


 @override
  void initState() {
    categories = getCategories();
        getSlider();
         getNews();

    super.initState();
  }
   getNews()async{
    News newsclass = News();
     await newsclass.getNews();
     articles = newsclass.news;
     print("Fetched Articles: ${articles.length}");
     setState(() {
       _loading = false;
     });
   }
   getSlider()async{
    Sliders slider = Sliders();
     await slider.getSlider();
     sliders = slider.sliders;
  
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Flutter'),
          Text('News',style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)

        ],),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading? Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.only(left: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index){
                  return CateogryTile(
                    image: categories[index].image,
                    categoryName: categories[index].categoryName,
                  );
                }),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Breaking News!", style:  TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                    ),
                     ),
                       GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Breaking")));
                        },
                         child: Text("View All!", style:  TextStyle(color: Colors.blue,
                                             fontWeight: FontWeight.w500,
                                             fontSize: 16
                                             ),
                                              ),
                       ),
                  ],
                ),
              ),
                          SizedBox(height: 30,),
        
              CarouselSlider.builder(
                itemCount: 5, 
                itemBuilder: (context, index, realImdex){
                  String? res= sliders[index].urlToImage;
                  String? res1 = sliders[index].title;
                  return buildImage(res!, index, res1!);
                }, 
                options: CarouselOptions(height: 250,
                 autoPlay: true,
                 enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason){
                  setState(() {
                    activeIndex =index;
                  });
                  }
                  )),
                  SizedBox(height: 30,),
                  Center(child: buildIndicator()),
                                  SizedBox(height: 30,),
        
                   Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Trending News!", style:  TextStyle(color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                    ),
                     ),
                       GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllNews(news: "Trending")));
                        },
                         child: Text("View All!", style:  TextStyle(color: Colors.blue,
                                             fontWeight: FontWeight.w500,
                                             fontSize: 16
                                             ),
                                              ),
                       ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
               
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index){
                      return BlockTile(
                        url: articles[index].url!,
                        desc: articles[index].description!,
                         imageUrl: articles[index].urlToImage!,
                          title: articles[index].title!);
                    }))
              //  SizedBox(height: 20,),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10),
              //   child: Material(
              //     elevation: 3.0,
              //     borderRadius: BorderRadius.circular(10),
              //     child: Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              //       child: Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //         Container(
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(10),
              //             child: Image.asset("images/sports.jpg", height: 150,width: 150,fit: BoxFit.cover,)),
              //         ),
              //         SizedBox(width: 8,),
              //            Column(
                    
              //              children: [
              //                Container(
              //                 width: MediaQuery.of(context).size.width/1.8,
              //                  child: Text("Rui Costa ouSprints breakway to win stage 15", style:  TextStyle(color: Colors.black,
              //                                      fontWeight: FontWeight.w500,
              //                                      fontSize: 17
              //                                      ),
              //                  ),
              //                ),
              //                SizedBox(height: 7,),
              //                Container(
              //                 width: MediaQuery.of(context).size.width/2,
              //                  child: Text("Then a final kick to beat  the mtch", style:  TextStyle(color: Colors.black54,
              //                    fontWeight: FontWeight.w500,
              //                   fontSize: 17
              //                   ),
              //                  ),
              //                ),
              //              ],
              //            ),
              //       ],),
                    
              //     ),
                  
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
   Widget buildImage(String image, int index, String name)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    child: Stack(
      children: [
       ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedNetworkImage(
          
        height: 250, fit: BoxFit.cover,
         width: MediaQuery.of(context).size.width,
         imageUrl: image,
         )),
         Container(
          height: 250,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 130),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            
            color: Colors.black26,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
            ),
          ),
          child: Center(child: Text(name,
          maxLines: 2,
           style: TextStyle(color: Colors.white,fontSize: 20.0, fontWeight: FontWeight.bold),)),
         )
    ]),
  );
    
    Widget buildIndicator()=> AnimatedSmoothIndicator(
      activeIndex: activeIndex,
       count: 5,
       effect: SlideEffect(dotWidth: 15,dotHeight: 15, activeDotColor: Colors.blue),
       );

    
}
class CateogryTile extends StatelessWidget {
  final image, categoryName;
  CateogryTile({this.image,this.categoryName});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> CategoryNews(name: categoryName)));
    },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(image,
               width: 120,
                height: 60, fit: BoxFit.cover,),
            ),
            Container(
                width: 120,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26,
                ),
              child: Center(child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 15,fontWeight: FontWeight.bold,
                )
                ,)),
            )
          ],
        ),
      ),
    );
  }
 
}


class BlockTile extends StatefulWidget {
String imageUrl, title, desc, url;
BlockTile({ required this.desc, required this.imageUrl,required this.url, required this.title});
  @override
  State<BlockTile> createState() => _BlockTileState();
}

class _BlockTileState extends State<BlockTile> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: widget.url)));
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Material(
                      elevation: 3.0,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                              imageUrl: widget.imageUrl,
                                 height: 150,
                                 width: 150,fit: 
                                 BoxFit.cover,
                                 
                              
                                 )),
                          ),
                          SizedBox(width: 8,),
                             Column(
                        
                               children: [
                                 Container(
                                  width: MediaQuery.of(context).size.width/1.8,
                                   child: Text(widget.title,
                                   maxLines: 2, style:  TextStyle(color: Colors.black,
                                                       fontWeight: FontWeight.w500,
                                                       fontSize: 17
                                                       ),
                                   ),
                                 ),
                                 SizedBox(height: 7,),
                                 Container(
                                  width: MediaQuery.of(context).size.width/2,
                                   child: Text(widget.desc,
                                   maxLines: 3,
                                    style:  TextStyle(color: Colors.black54,
                                     fontWeight: FontWeight.w500,
                                    fontSize: 17
                                    ),
                                   ),
                                 ),
                               ],
                             ),
                        ],),
                        
                      ),
                      
                    ),
                  ),
                ),
              );
  }
}