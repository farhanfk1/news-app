import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
String name;
CategoryNews({required this.name});
  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
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
        child: ,
      )
    );
  }
}
class ShowCaegory extends StatelessWidget {
String image, desc, title;
ShowCaegory({required this.desc, required this.image, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: image,
          width: MediaQuery.of(context).size.width,
          height: 200,
          fit: BoxFit.cover,
          ),
          Text(title),
          Text(title),

        ],
      ),    
    );
  }
}