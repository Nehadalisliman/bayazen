/*import 'package:e_learning/Controllers/student_controller.dart';
import '../../Models/home_teacher_response_model.dart';
import 'package:e_learning/Widgets/error_widget.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/helpers/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomeStudent extends StatefulWidget {
  const HomeStudent({Key key}) : super(key: key);

  @override
  State<HomeStudent> createState() => _HomeStudentState();
}

class _HomeStudentState extends State<HomeStudent> {
  String errorMessage = '';
  SizeConfig sizeConfig = SizeConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<HomeResponseModel>(
        future: StudentController().getHomeStudent(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return HasError(
              errorText: errorMessage ?? '',
            );
          } else {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: sizeConfig.screenWidth,
                      height: sizeConfig.screenHeight * .4,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: sizeConfig.screenHeight * .2,
                            right: sizeConfig.screenWidth * .09),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text('صباح الخير',
                                style: TextStyle(
                                    color: buttonTextColor,
                                    fontFamily: 'Janna LT Regular',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold)),
                            Text(snapshot?.data?.firstName,
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontFamily: 'Janna LT Regular',
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold)),
                            const ListTile(
                              trailing: Text('سراء اسراء اسراء اسراء',
                                  style: TextStyle(
                                      color: textColor,
                                      fontFamily: 'Janna LT Regular',
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: containerColor.withOpacity(.2),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                    ),
                    const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 15),
                          child: Text('ماذا سوف تفعل اليوم؟',
                              style: TextStyle(
                                  color: accentColor,
                                  fontFamily: 'Janna LT Regular',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: sizeConfig.screenHeight * .05,
                              left: sizeConfig.screenWidth * .03),
                          // ignore: deprecated_member_use
                          child: TextButton(
                              onPressed: () {
                                //  Get.to(ConfirmPassword());
                              },
                              child: const Text(
                                ' اشتراك',
                                style: TextStyle(
                                    color: buttonTextColor,
                                    fontFamily: 'Janna LT Regular',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: sizeConfig.screenWidth * .1,
                              top: sizeConfig.screenHeight * .05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                'المحتوي الدراسي',
                                style: TextStyle(
                                    color: accentColor,
                                    fontFamily: 'Janna LT Regular',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: sizeConfig.screenWidth * .08,
                              ),
                              Image.asset('assets/presentation.png')
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: sizeConfig.screenHeight * .05,
                              left: sizeConfig.screenWidth * .03),
                          // ignore: deprecated_member_use
                          child: TextButton(
                              onPressed: () {
                                //  Get.to(ConfirmPassword());
                              },
                              child: const Text(
                                ' مشاهده الان',
                                style: TextStyle(
                                    color: buttonTextColor,
                                    fontFamily: 'Janna LT Regular',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: sizeConfig.screenWidth * .1,
                              top: sizeConfig.screenHeight * .05),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                ' المجله',
                                style: TextStyle(
                                    color: accentColor,
                                    fontFamily: 'Janna LT Regular',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              ),
                              SizedBox(
                                width: sizeConfig.screenWidth * .08,
                              ),
                              Image.asset(
                                'assets/magazine.jpg',
                                height: 32,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 20, top: 15),
                          child: Text('اراء عملائنا من المدرسين',
                              style: TextStyle(
                                  color: accentColor,
                                  fontFamily: 'Janna LT Regular',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        )),
                    SizedBox(
                      width: sizeConfig.screenWidth,
                      height: sizeConfig.screenHeight * .2,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.topFive.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  OutlinedButton(
                                    style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: primaryColor,
                                                width: 1.0,
                                                style: BorderStyle.solid))),
                                    onPressed: () {},
                                    child: const Text(' مشاهده'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        const Text('مدرس',
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontFamily: 'Janna LT Regular',
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        Text(snapshot.data?.topFive[index].name,
                                            style: const TextStyle(
                                                color: accentColor,
                                                fontFamily: 'Janna LT Regular',
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold)),
                                        RatingBar.builder(
                                          initialRating: double.parse(
                                              '${snapshot.data?.topFive[index].rating}'),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            size: 6,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {},
                                        ),
                                        // Text('${snapshot.data?.topFive[index].comment}',style: TextStyle(color: accentColor,fontFamily: 'Janna LT Regular',fontSize: 13,fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/teacher.jpg',
                                        width: 100,
                                      ))
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 3,
                            );
                          }),
                    )
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: primaryColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        // currentIndex: snapshot.data.index,
        //  onTap: _bottomNavBarBloc.pickItem,
        items: [
          const BottomNavigationBarItem(
            label: 'Search',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Browse',
            icon: InkWell(
                onTap: () {
                  // Get.to(StudentProfile());
                },
                child: const Icon(Icons.person_rounded)),
          ),
          const BottomNavigationBarItem(
            label: 'Favorites',
            icon: Icon(Icons.chat_bubble_outline),
          ),
          const BottomNavigationBarItem(
            label: 'Settings',
            icon: Icon(Icons.content_paste),
          ),
        ],
      ),
    );
  }
}
*/