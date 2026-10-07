import 'package:e_learning/constants.dart';
import 'package:e_learning/core/helpers/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class Invitation  extends StatelessWidget {
  SizeConfig sizeConfig=SizeConfig();
  bool? isSelected;
  Invitation({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('دعوة مؤثرين',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 18,fontWeight: FontWeight.bold)),
        leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back,color: accentColor,)),
        backgroundColor: buttonTextColor,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(right: sizeConfig.screenWidth*.1,top: sizeConfig.screenHeight*.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.group_add),
                Column(
                  children: const [
                    Text('سهيله احمد',style: TextStyle(color: primaryColor,fontFamily: 'Janna LT Regular',fontSize: 13,fontWeight: FontWeight.bold)),
                    Text('مدرس فيزياء ',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 13,fontWeight: FontWeight.bold)),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/teacher.jpg'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: sizeConfig.screenWidth*.1,top: sizeConfig.screenHeight*.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.group_add),
                Column(
                  children: const [
                    Text('سهيله احمد',style: TextStyle(color: primaryColor,fontFamily: 'Janna LT Regular',fontSize: 13,fontWeight: FontWeight.bold)),
                    Text('مدرس فيزياء ',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 13,fontWeight: FontWeight.bold)),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/teacher.jpg'),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: sizeConfig.screenWidth*.1,top: sizeConfig.screenHeight*.1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.group_add),
                Column(
                  children: const [
                    Text('سهيله احمد',style: TextStyle(color: primaryColor,fontFamily: 'Janna LT Regular',fontSize: 13,fontWeight: FontWeight.bold)),
                    Text('مدرس فيزياء ',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 13,fontWeight: FontWeight.bold)),
                  ],
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/teacher.jpg'),
                )
              ],
            ),
          ),


        ],
      ),
      bottomNavigationBar:BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        fixedColor:primaryColor,
        showSelectedLabels:false,
        showUnselectedLabels:false,
        // currentIndex: snapshot.data.index,
        //  onTap: _bottomNavBarBloc.pickItem,
        items:[
          const BottomNavigationBarItem(
            label:'Search',
            icon:Icon(Icons.home),
          ),
          const BottomNavigationBarItem(
            label:'Browse',
            icon:Icon(Icons.group_add),
          ),
          const BottomNavigationBarItem(
            label:'Favorites',
            icon:Icon(Icons.add_circle,color: primaryColor,size: 50,),
          ),
          const BottomNavigationBarItem(
            label:'Favorites',
            icon:Icon(Icons.chat_bubble_outline,),
          ),
          BottomNavigationBarItem(
            label:'content',
            icon:InkWell(
                onTap:(){
                  //  Get.to(Content());
                },
                child:isSelected==true?const Icon(Icons.content_paste,color: primaryColor,):const Icon(Icons.content_paste)),
          ),
        ],
      ),

    );

  }
}
