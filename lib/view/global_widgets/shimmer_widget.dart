import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({super.key, required this.portraitCount, required this.landScapeCount, required this.portraitItemCount, required this.landscapeItemCount});
final int portraitCount;
final int landScapeCount;
final int portraitItemCount;
final int landscapeItemCount;

  @override
  Widget build(BuildContext context)=>OrientationBuilder(
    builder: (context, orientation) {
         final customSize=MediaQuery.of(context).size;
      final isPortrait=orientation==Orientation.portrait;
    return GridView.builder(
      itemCount: isPortrait?portraitItemCount:landscapeItemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: isPortrait?customSize.height*.24:customSize.height*.56,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
       
        crossAxisCount: isPortrait?portraitCount:landScapeCount,
    ), itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.only(bottom:8.0),
        child: Shimmer(
                enabled:true,
                 color: Colors.grey,
               
                 colorOpacity: 0.3,
                direction: const ShimmerDirection.fromLTRB(),
                child: Container( 
                 
                   decoration:   BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        boxShadow:  [
          BoxShadow(
          offset:const Offset(-1, -1),
          blurRadius: 5,
          color: Colors.grey.withOpacity(.3),
        
        
        ),
          BoxShadow(
          offset:const Offset(2, 2),
          blurRadius: 5,
        color: Colors.grey.withOpacity(.3),
           
        )
        ]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 5,),
            Container(
                        width: double.infinity,
                    height: MediaQuery.of(context).size.height*.1,
                          decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          boxShadow:  [
            BoxShadow(
            offset:const Offset(-1, -1),
            blurRadius: 10,
            color: Colors.grey.withOpacity(.2),     
          ),
            BoxShadow(
            offset:const Offset(2, 2),
            blurRadius: 10,
          color: Colors.grey.withOpacity(.2),
             
          )
          ]
          ),
                      ),
                                const SizedBox(height: 5,),
            Container(
                        width: 100,
                        height: 15,
                          decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          boxShadow:  [
            BoxShadow(
            offset:const Offset(-1, -1),
            blurRadius: 5,
            color: Colors.grey.withOpacity(.2),     
          ),
            BoxShadow(
            offset:const Offset(2, 2),
            blurRadius: 5,
          color: Colors.grey.withOpacity(.2),
             
          )
          ]
          ),
          
                      ),
                                const SizedBox(height: 5,),
        
                      Container(
                        width: 80,
                        height: 15,
                          decoration:   BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          boxShadow:  [
            BoxShadow(
            offset:const Offset(-1, -1),
            blurRadius: 5,
            color: Colors.grey.withOpacity(.2),     
          ),
            BoxShadow(
            offset:const Offset(2, 2),
            blurRadius: 5,
          color: Colors.grey.withOpacity(.2),
             
          )
          ]
          ),
                      ),],),
        ),
                ),
              ),
      );
    });
  });
}