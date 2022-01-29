import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import 'package:News_App/shared/cubit/cubit.dart';

import '../../modules/web_view/web_view_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  Color color = Colors.blue,
  double radius = 10.0,
  required Function function,
  String text = "test",
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(radius)),
    child: MaterialButton(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        function();
      },
    ),
  );
}

Widget defaultFormField({
  String? labelText,
  required TextEditingController controler,
  bool isObSecureText = false,
  required TextInputType keyboardType,
  IconData? prefexIcon,
  IconData? safexIcon,
  required Function validat,
  Function? prefex_pressed,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
}) {
  return TextFormField(
    controller: controler,
    obscureText: isObSecureText,
    keyboardType: keyboardType,
    onTap: () {
      onTap!();
    },
    onFieldSubmitted: (value) {
      //print(value);
      onSubmit!(value);
    },
    onChanged: (s) {
      onChange!(s);
    },
    validator: (s) {
      return validat(s);
    },
    decoration: InputDecoration(
// border: InputBorder.none,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        labelText: labelText,
// label: Text("gggggg")

        prefixIcon: IconButton(
          icon: Icon(prefexIcon),
          onPressed: () {}
          //print("prefex presssed");
          ,
        ),
        suffixIcon: Icon(safexIcon)),
  );
}
Widget BuildArticleItem({
  required article,
  required context
}){
  return  InkWell(

    onTap: () {
      navigateTo(context, WebViewScreen(article['url']));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,

            child: CachedNetworkImage(imageUrl: '${article["urlToImage"]}',
            imageBuilder: (context,image)=>Container(

              decoration: BoxDecoration(
                color: Colors.amber,
               // border: Border.all(width: 5,style:BorderStyle.solid ),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(image: image,fit: BoxFit.cover)

                    
              ),
            ),
            errorWidget: (context,url,error)=>Icon(Icons.error),
            ),

            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),


              //NetworkImage(""),
            ),
          ),
          // CachedNetworkImage(
          //   imageUrl: '${article["urlToImage"]}',
          //   imageBuilder: (context, imageProvider) => Container(
          //     height: 120.0,
          //     width: 120.0,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //
          //           image: imageProvider,
          //           fit: BoxFit.cover,
          //           colorFilter:
          //           ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
          //     ),
          //   ),

          //   errorWidget: (context, url, error) =>  Container(
          //     height: 120.0,
          //     width: 120.0,
          //     child: Icon(
          //
          //         Icons.error,
          //       size: 40,
          //     ),
          //     decoration: BoxDecoration(
          //       color: Colors.blueGrey,
          //       borderRadius: BorderRadius.circular(10),
          //
          //     ),
          //   ),
          // ),


          SizedBox(width: 10,),
          Expanded(
            child:Container(
              height: 120,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${article["title"]}",
                      style:Theme.of(context).textTheme.bodyText1,
                      maxLines:3,
                      overflow:  TextOverflow.ellipsis,),
                  ),
                  Text("${article["publishedAt"]}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),


                  ),


                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}
Widget BuildSeperatItem(){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
  );
}

Widget articleBuilder(list,{ isSearch=false})=>ConditionalBuilder(
  condition: list.isEmpty,
  builder: (context) =>isSearch?Container(): Center(child: CircularProgressIndicator()),
  fallback: (context) =>  ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder:(context,index) =>BuildArticleItem(article: list[index],context: context),
      separatorBuilder:(context,index) =>BuildSeperatItem(),
      itemCount: list.length),
);

void navigateTo(context,widget)=>Navigator.push(
  context,MaterialPageRoute(builder: (context)=>widget ));