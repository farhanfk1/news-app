import 'package:news_app/models/slider_model.dart';

List<sliderModel> getSlider(){

 List<sliderModel> slider = [];
 sliderModel categoryModel = new sliderModel();

 categoryModel.image= "images/business.jpg";
 categoryModel.name = "BOW to the Authority of Silenforce";
 slider.add(categoryModel);
 categoryModel=new sliderModel();

 categoryModel.image= "images/entertainment.jpg";
 categoryModel.name = "BOW to the Authority of Silenforce";
 slider.add(categoryModel);
 categoryModel=new sliderModel();

  categoryModel.image= "images/sports.jpg";
 categoryModel.name = "BOW to the Authority of Silenforce";
 slider.add(categoryModel);
 categoryModel=new sliderModel();

  categoryModel.image= "images/health.jpg";
 categoryModel.name = "BOW to the Authority of Silenforce";
 slider.add(categoryModel);
 categoryModel=new sliderModel();

 categoryModel.image= "images/generl.jpg";
 categoryModel.name = "BOW to the Authority of Silenforce";
 slider.add(categoryModel);
 categoryModel=new sliderModel();

 return slider;
}