import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({super.key, required this.press, required this.longPress, required this.image, required this.name, required this.price, required this.desc});
final Function() press;
final Function() longPress;
final String image,name,desc;
final dynamic price;
  @override
  Widget build(BuildContext context) {
    var customSize=MediaQuery.of(context).size;
    return Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                onTap:press,
                onLongPress: longPress,
                child: Container(        
                                        decoration: BoxDecoration(
                                    color: Colors.white,
                                                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.2)),
                                                      boxShadow: [BoxShadow(
                                                      offset: const Offset(-2, 2),
                                                      blurRadius: 5,
                                                      color: Colors.grey.withOpacity(.5)
                                                      )],
                                                      borderRadius:  const BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20),)
                                              ),
                                                  child:  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children:  [
                                                    ClipRRect(
                                                      borderRadius:  const BorderRadius.only(topLeft: Radius.circular(50),bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20),),
                                                      child: CachedNetworkImage(imageUrl: image,
                                                      progressIndicatorBuilder: (context, url, downloadProgress) => 
                CircularProgressIndicator(value: downloadProgress.progress),
                 errorWidget: (context, url, error) =>  Image.asset(Images.loadingImage),
                                                      ),
                                                    ),
                                                    SizedBox(height: customSize.height*.01,),
                                                    Text(name,style: const TextStyle(color: Colors.black),),
                                                  Text(desc,style: const TextStyle(color: Colors.black),),
                                                  Text(price.toString(),style: const TextStyle(color: Colors.black)),
                                                                    ])),
              ),

                        
            );
  }
}