// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:e_learning/Controllers/auth/celeb_auth_controller.dart';
import 'package:e_learning/Controllers/celeb/content_controller.dart';
import 'package:e_learning/Models/profile_response_model.dart';
import 'package:e_learning/Widgets/custom_text_field.dart';
import 'package:e_learning/Widgets/vedio_item.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/core/helpers/size_config.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
// import 'package:share_plus/share_plus.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:video_player/video_player.dart';

import '../../Widgets/custom_nav_bar.dart';

class TeacherProfile extends StatefulWidget {
  TeacherProfile({Key? key}) : super(key: key);

  @override
  State<TeacherProfile> createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  SizeConfig sizeConfig = SizeConfig();
  TextEditingController textEducation1 = TextEditingController();
  TextEditingController textEducation2 = TextEditingController();
  TextEditingController textEducation3 = TextEditingController();
  TextEditingController textEducation4 = TextEditingController();
  TextEditingController textExperience1 = TextEditingController();
  TextEditingController textExperience2 = TextEditingController();
  TextEditingController textExperience3 = TextEditingController();
  TextEditingController textExperience4 = TextEditingController();
  TextEditingController textInterest1 = TextEditingController();
  TextEditingController textInterest2 = TextEditingController();
  TextEditingController textInterest3 = TextEditingController();
  TextEditingController textSkill1 = TextEditingController();
  TextEditingController textSkill2 = TextEditingController();
  TextEditingController textSkill3 = TextEditingController();
  bool? isSelected;
  final RxBool isVisible = RxBool(false);
  double progress = 0.0;
  RxInt number = RxInt(0);
  File? _video;
  PlatformFile? _file;
  late VideoPlayerController _videoPlayerController;
  final video = ImagePicker();

  _pickVideo() async {
    final videoo = (await video.pickVideo(source: ImageSource.gallery))!;
    _file = PlatformFile(path: videoo.path, name: '', size: 10);
    setState(() {
      progress = _file!.size.toDouble();
    });

    // _videoPlayerController=VideoPlayerController.file(_file)
    // ..initialize().then((_)  {
    //   setState(() {
    //     debugPrint("========"+_videoPlayerController.value.duration.toString());
    //
    //   });
    //   _videoPlayerController.play();
    // });
  }

  final CelebAuthController controller = Get.put(CelebAuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CelebAuthController().getProfileData();
  }

  File? image;
  final picker = ImagePicker();

  // PlatformFile file;
  // void _pickFile() async {
  //   final imagee=await picker.getImage(source: ImageSource.gallery);
  //   image=File(imagee.path);
  //
  //
  // }
  PlatformFile? file;

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.first;
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.delayed(Duration.zero, () {
        CelebAuthController().getProfileData();
      }),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text('الصفحه الشخصيه',
              style: TextStyle(
                  color: accentColor,
                  fontFamily: 'Janna LT Regular',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back,
                color: accentColor,
              )),
          backgroundColor: buttonTextColor,
        ),
        body: FutureBuilder<ProfileResponseModel>(
            future: controller.getProfileData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    right: sizeConfig.screenWidth * .03,
                                    top: sizeConfig.screenHeight * .1),
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage(snapshot.data!.image!),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: sizeConfig.screenHeight * .07,
                                          right: sizeConfig.screenWidth * .03),
                                      // ignore: deprecated_member_use
                                      child: TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    title:
                                                        Text('   تعديل الصوره'),
                                                    children: [
                                                      SingleChildScrollView(
                                                        child: Form(
                                                          child: Column(
                                                            children: [
                                                              if (file != null)
                                                                Image.file(File(
                                                                    file!
                                                                        .path!))
                                                              else
                                                                Container(
                                                                    margin: const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            20),
                                                                    width: 300,
                                                                    height: 100,
                                                                    color: Colors
                                                                        .grey
                                                                        .shade200,
                                                                    child: InkWell(
                                                                        onTap: () {
                                                                          _pickFile();
                                                                        },
                                                                        child: const Icon(
                                                                          Icons
                                                                              .cloud_upload_outlined,
                                                                          color:
                                                                              primaryColor,
                                                                        ))),
                                                              Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            15),
                                                                // ignore: deprecated_member_use
                                                                child:
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          //

                                                                          // ContentController().updateData(
                                                                          //     data: file,
                                                                          //     modification: 'image');
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          ' حفظ',
                                                                          style: TextStyle(
                                                                              color: buttonTextColor,
                                                                              fontFamily: 'Janna LT Regular',
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18),
                                                                        )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                            //  Get.to(ConfirmPassword());
                                          },
                                          child: const Text(
                                            'تعديل ',
                                            style: TextStyle(
                                                color: buttonTextColor,
                                                fontFamily: 'Janna LT Regular',
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      // Share.share(
                                      //     "https://play.google.com/store/apps/details?id=com.education.learn");
                                    },
                                    child: Icon(Icons.share)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ShowUpAnimation(
                                                  delayStart:
                                                      Duration(seconds: 1),
                                                  animationDuration:
                                                      Duration(seconds: 1),
                                                  curve: Curves.fastOutSlowIn,
                                                  child: SimpleDialog(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              "   عضو مميز   ${snapshot.data!.name}")
                                                        ],
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });
                                        },
                                        child: Image.asset(
                                          'assets/biazin.png',
                                          height: 30,
                                          width: 30,
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top: sizeConfig.screenHeight * .01),
                                        child: snapshot.data!.name == null
                                            ? SizedBox()
                                            : Text(
                                                '${snapshot.data!.name ?? ""}',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Janna LT Regular',
                                                    color: accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18))),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SimpleDialog(
                                            title: Text('     تعديل التخصص'),
                                            children: [
                                              Obx(
                                                () => CustomTextField(
                                                  initialValue: snapshot
                                                      .data!.specialization,
                                                  onChanged: (value) {
                                                    snapshot.data!
                                                        .specialization = value;
                                                  },
                                                  secureText: isVisible.value
                                                      ? true
                                                      : false,
                                                  // initialValue: snapshot.data.bio,
                                                  //controller: bio,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  // ContentController()
                                                  //     .updateData(
                                                  //         data: snapshot.data!
                                                  //             .specialization,
                                                  //         modification: 'spec');
                                                },
                                                child: Text('حفظ'),
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: Icon(Icons.edit)),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: sizeConfig.screenWidth * .6,
                                      top: sizeConfig.screenHeight * .03),
                                  child: snapshot.data!.specialization == null
                                      ? SizedBox()
                                      : Text('${snapshot.data!.specialization}',
                                          style: TextStyle(
                                              fontFamily: 'Janna LT Regular',
                                              color: accentColor,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 17))),
                            ],
                          ),
                          Column(
                            children: [
                              InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return ShowUpAnimation(
                                            delayStart: Duration(seconds: 1),
                                            animationDuration:
                                                Duration(seconds: 1),
                                            curve: Curves.fastOutSlowIn,
                                            child: SimpleDialog(
                                              title: Text('   تعديل الفيديو'),
                                              children: [
                                                Column(
                                                  children: [
                                                    if (_file != null)
                                                      _videoPlayerController
                                                              .value
                                                              .isInitialized
                                                          ? AspectRatio(
                                                              aspectRatio:
                                                                  _videoPlayerController
                                                                      .value
                                                                      .aspectRatio,
                                                              child: VideoPlayer(
                                                                  _videoPlayerController),
                                                            )
                                                          : Container()
                                                    else
                                                      Container(
                                                          margin:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 20),
                                                          width: 300,
                                                          height: 100,
                                                          color: Colors
                                                              .grey.shade200,
                                                          child: InkWell(
                                                              onTap: () {
                                                                _pickVideo();
                                                              },
                                                              child: const Icon(
                                                                Icons
                                                                    .cloud_upload_outlined,
                                                                color:
                                                                    primaryColor,
                                                              ))),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 15),
                                                      // ignore: deprecated_member_use
                                                      child: TextButton(
                                                          onPressed: () {
                                                            //

                                                            // ContentController()
                                                            //     .updateData(
                                                            //         data: _file,
                                                            //         modification:
                                                            //             'personal_vid');
                                                          },
                                                          child: const Text(
                                                            ' حفظ',
                                                            style: TextStyle(
                                                                color:
                                                                    buttonTextColor,
                                                                fontFamily:
                                                                    'Janna LT Regular',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          )),
                                                    ),
                                                    Container(
                                                      width: 200,
                                                      height: 200,
                                                      child:
                                                          LiquidCircularProgressIndicator(
                                                        value: progress / 100,
                                                        valueColor:
                                                            AlwaysStoppedAnimation(
                                                                Colors.pink),
                                                        backgroundColor:
                                                            Colors.white,
                                                        direction:
                                                            Axis.vertical,
                                                        center: Text(
                                                            '${progress}%'),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                    ],
                                  )),
                              Card(
                                child: AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: VideoItems(
                                    videoPlayerController:
                                        VideoPlayerController.network(
                                            snapshot.data!.personalVid),
                                    looping: true,
                                    autoplay: true,
                                    width: sizeConfig.screenWidth,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              height: sizeConfig.screenHeight * .2,
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              child: Icon(Icons.edit),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return SimpleDialog(
                                                        title: Text(
                                                            ' تحرير قسم نبذه عني'),
                                                        children: [
                                                          Obx(
                                                            () =>
                                                                CustomTextField(
                                                              initialValue:
                                                                  snapshot.data!
                                                                      .bio,
                                                              onChanged:
                                                                  (value) {
                                                                snapshot.data!
                                                                        .bio =
                                                                    value;
                                                              },
                                                              secureText:
                                                                  isVisible
                                                                          .value
                                                                      ? true
                                                                      : false,
                                                              // initialValue: snapshot.data.bio,
                                                              //controller: bio,
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              // ContentController()
                                                              //     .updateData(
                                                              //         data: snapshot
                                                              //             .data!
                                                              //             .bio,
                                                              //         modification:
                                                              //             'bio');
                                                            },
                                                            child: Text('حفظ'),
                                                          )
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                            Text('نبذة عنا',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Janna LT Regular',
                                                    color: accentColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Expanded(
                                                child: snapshot.data!.bio ==
                                                        null
                                                    ? SizedBox()
                                                    : Text(
                                                        ' ${snapshot.data!.bio}',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Janna LT Regular',
                                                            color: accentColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 12))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              height: sizeConfig.screenHeight * .2,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Icon(Icons.edit),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return SimpleDialog(
                                                    title: Text('   الخبرات'),
                                                    children: [
                                                      Column(
                                                        children: [
                                                          snapshot.data!
                                                                      .experience ==
                                                                  null
                                                              ? CustomTextField(
                                                                  controller:
                                                                      textExperience1,
                                                                  //controller: bio,
                                                                )
                                                              : CustomTextField(
                                                                  initialValue:
                                                                      snapshot
                                                                          .data!
                                                                          .experience![0],
                                                                  onChanged:
                                                                      (value) {
                                                                    snapshot.data!
                                                                            .experience![
                                                                        0] = value;
                                                                  },
                                                                  //controller: bio,
                                                                ),
                                                          snapshot.data!
                                                                      .experience ==
                                                                  null
                                                              ? CustomTextField(
                                                                  controller:
                                                                      textExperience2,
                                                                  //controller: bio,
                                                                )
                                                              : CustomTextField(
                                                                  initialValue:
                                                                      snapshot
                                                                          .data!
                                                                          .experience![1],
                                                                  onChanged:
                                                                      (value) {
                                                                    snapshot.data!
                                                                            .experience![
                                                                        1] = value;
                                                                  },
                                                                  //controller: bio,
                                                                ),
                                                          snapshot.data!
                                                                      .experience ==
                                                                  null
                                                              ? CustomTextField(
                                                                  controller:
                                                                      textExperience3
                                                                  //controller: bio,
                                                                  )
                                                              : CustomTextField(
                                                                  initialValue:
                                                                      snapshot
                                                                          .data!
                                                                          .experience![2],
                                                                  onChanged:
                                                                      (value) {
                                                                    snapshot.data!
                                                                            .experience![
                                                                        2] = value;
                                                                  },
                                                                  //controller: bio,
                                                                ),
                                                          snapshot.data!
                                                                      .experience ==
                                                                  null
                                                              ? CustomTextField(
                                                                  controller:
                                                                      textExperience4,
                                                                  //controller: bio,
                                                                )
                                                              : CustomTextField(
                                                                  initialValue:
                                                                      snapshot
                                                                          .data!
                                                                          .experience![3],
                                                                  onChanged:
                                                                      (value) {
                                                                    snapshot.data!
                                                                            .experience![
                                                                        3] = value;
                                                                  },
                                                                  //controller: bio,
                                                                )
                                                        ],
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          // ContentController()
                                                          // .updateData(
                                                          //     data: {
                                                          //   "data[0]": snapshot
                                                          //               .data!
                                                          //               .experience ==
                                                          //           null
                                                          //       ? textExperience1
                                                          //           .text
                                                          //       : snapshot
                                                          //           .data!
                                                          //           .experience![0],
                                                          //   "data[1]": snapshot
                                                          //               .data!
                                                          //               .experience ==
                                                          //           null
                                                          //       ? textExperience2
                                                          //           .text
                                                          //       : snapshot
                                                          //           .data!
                                                          //           .experience![1],
                                                          //   "data[2]": snapshot
                                                          //               .data!
                                                          //               .experience ==
                                                          //           null
                                                          //       ? textExperience3
                                                          //           .text
                                                          //       : snapshot
                                                          //           .data!
                                                          //           .experience![2],
                                                          //   "data[3]": snapshot
                                                          //               .data!
                                                          //               .experience ==
                                                          //           null
                                                          //       ? textExperience4
                                                          //           .text
                                                          //       : snapshot
                                                          //           .data!
                                                          //           .experience![3]
                                                          // },
                                                          //     modification:
                                                          //         'experience');
                                                        },
                                                        child: Text('حفظ'),
                                                      )
                                                    ],
                                                  );
                                                });
                                          },
                                        ),
                                        Text('الخبرات ',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: 'Janna LT Regular',
                                                color: accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  snapshot.data!.experience == null
                                      ? SizedBox()
                                      : Expanded(
                                          child: SizedBox(
                                          child: ListView.builder(
                                              itemCount: snapshot
                                                  .data!.experience!.length,
                                              itemBuilder: (context, number) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          '${snapshot.data!.experience![number]}'),

                                                      // Text('${snapshot.data.experience[index][3]}'),
                                                    ],
                                                  ),
                                                );
                                              }),
                                          height: 300,
                                        )),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              height: sizeConfig.screenHeight * .2,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Icon(Icons.edit),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                        height: 300.0,
                                                        // Change as per your requirement
                                                        width: 300.0,
                                                        // Change as per your requirement
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              snapshot.data!
                                                                          .eduction ==
                                                                      null
                                                                  ? CustomTextField(
                                                                      controller:
                                                                          textEducation1,
                                                                    )
                                                                  : CustomTextField(
                                                                      initialValue: snapshot.data!.eduction![0] ==
                                                                              null
                                                                          ? ""
                                                                          : snapshot
                                                                              .data!
                                                                              .eduction![0],
                                                                      onChanged:
                                                                          (value) {
                                                                        snapshot
                                                                            .data!
                                                                            .eduction![0] = value;
                                                                      },
                                                                    ),
                                                              snapshot.data!
                                                                          .eduction ==
                                                                      null
                                                                  ? CustomTextField(
                                                                      controller:
                                                                          textEducation2,
                                                                    )
                                                                  : CustomTextField(
                                                                      initialValue: snapshot.data!.eduction![1] ==
                                                                              null
                                                                          ? ""
                                                                          : snapshot
                                                                              .data!
                                                                              .eduction![1],
                                                                      onChanged:
                                                                          (value) {
                                                                        snapshot
                                                                            .data!
                                                                            .eduction![1] = value;
                                                                      },
                                                                    ),
                                                              snapshot.data!
                                                                          .eduction ==
                                                                      null
                                                                  ? CustomTextField(
                                                                      controller:
                                                                          textEducation3,
                                                                    )
                                                                  : CustomTextField(
                                                                      initialValue: snapshot.data!.eduction![2] ==
                                                                              null
                                                                          ? ""
                                                                          : snapshot
                                                                              .data!
                                                                              .eduction![2],
                                                                      onChanged:
                                                                          (value) {
                                                                        snapshot
                                                                            .data!
                                                                            .eduction![2] = value;
                                                                      },
                                                                    ),
                                                              snapshot.data!
                                                                          .eduction ==
                                                                      null
                                                                  ? CustomTextField(
                                                                      controller:
                                                                          textEducation4,
                                                                    )
                                                                  : CustomTextField(
                                                                      initialValue: snapshot.data!.eduction![3] ==
                                                                              null
                                                                          ? ""
                                                                          : snapshot
                                                                              .data!
                                                                              .eduction![3],
                                                                      onChanged:
                                                                          (value) {
                                                                        snapshot
                                                                            .data!
                                                                            .eduction![3] = value;
                                                                      },
                                                                    ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  // ContentController()
                                                                  //     .updateData(
                                                                  //         data: {
                                                                  //       "data[0]": snapshot.data!.eduction ==
                                                                  //               null
                                                                  //           ? textEducation1.text
                                                                  //           : snapshot.data!.eduction![0],
                                                                  //       "data[1]": snapshot.data!.eduction ==
                                                                  //               null
                                                                  //           ? textEducation2.text
                                                                  //           : snapshot.data!.eduction![1],
                                                                  //       "data[2]": snapshot.data!.eduction ==
                                                                  //               null
                                                                  //           ? textEducation3.text
                                                                  //           : snapshot.data!.eduction![2],
                                                                  //       "data[3]": snapshot.data!.eduction ==
                                                                  //               null
                                                                  //           ? textEducation4.text
                                                                  //           : snapshot.data!.eduction![3]
                                                                  //     },
                                                                  //         modification:
                                                                  //             'education');
                                                                },
                                                                child:
                                                                    Text('حفظ'),
                                                              )
                                                            ],
                                                          ),
                                                        )),
                                                  );
                                                });
                                          },
                                        ),
                                        Text('التعليم ',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: 'Janna LT Regular',
                                                color: accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  snapshot.data!.eduction == null
                                      ? SizedBox()
                                      : Expanded(
                                          child: ListView.builder(
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                        '${snapshot.data!.eduction![index]}'),
                                                  ],
                                                ),
                                              );
                                            },
                                            itemCount:
                                                snapshot.data!.eduction!.length,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              height: sizeConfig.screenHeight * .2,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        content: Container(
                                                          height: 300.0,
                                                          // Change as per your requirement
                                                          width: 300.0,
                                                          // Change as per your requirement
                                                          child: Column(
                                                            children: [
                                                              snapshot.data!
                                                                          .skills ==
                                                                      null
                                                                  ? CustomTextField(
                                                                      controller:
                                                                          textSkill1,
                                                                    )
                                                                  : CustomTextField(
                                                                      initialValue: snapshot
                                                                          .data!
                                                                          .skills![0],
                                                                      onChanged:
                                                                          (value) {
                                                                        snapshot
                                                                            .data!
                                                                            .skills![0] = value;
                                                                      },
                                                                    ),
                                                              snapshot.data!
                                                                          .skills ==
                                                                      null
                                                                  ? CustomTextField(
                                                                      controller:
                                                                          textSkill2,
                                                                    )
                                                                  : CustomTextField(
                                                                      initialValue: snapshot
                                                                          .data!
                                                                          .skills![1],
                                                                      onChanged:
                                                                          (value) {
                                                                        snapshot
                                                                            .data!
                                                                            .skills![1] = value;
                                                                      },
                                                                    ),
                                                              snapshot.data!
                                                                          .skills ==
                                                                      null
                                                                  ? CustomTextField(
                                                                      controller:
                                                                          textSkill3,
                                                                    )
                                                                  : CustomTextField(
                                                                      initialValue: snapshot
                                                                          .data!
                                                                          .skills![2],
                                                                      onChanged:
                                                                          (value) {
                                                                        snapshot
                                                                            .data!
                                                                            .skills![2] = value;
                                                                      },
                                                                    ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  // ContentController()
                                                                  // .updateData(
                                                                  //     data: {
                                                                  //   "data[0]": snapshot.data!.skills ==
                                                                  //           null
                                                                  //       ? textSkill1.text
                                                                  //       : snapshot.data!.skills![0],
                                                                  //   "data[1]": snapshot.data!.skills ==
                                                                  //           null
                                                                  //       ? textSkill2.text
                                                                  //       : snapshot.data!.skills![1],
                                                                  //   "data[2]": snapshot.data!.skills ==
                                                                  //           null
                                                                  //       ? textSkill3.text
                                                                  //       : snapshot.data!.skills![2]
                                                                  // },
                                                                  //     modification:
                                                                  //         'skills');
                                                                },
                                                                child:
                                                                    Text('حفظ'),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: Icon(Icons.edit)),
                                        ),
                                        Text(' المهارات',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: 'Janna LT Regular',
                                                color: accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  snapshot.data!.skills == null
                                      ? SizedBox()
                                      : Expanded(
                                          child: SizedBox(
                                            height: 400,
                                            child: ListView.builder(
                                              itemBuilder: (snap, index) {
                                                return Card(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Text(
                                                            '${snapshot.data!.skills![index]}'),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount:
                                                  snapshot.data!.skills!.length,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: SizedBox(
                              height: sizeConfig.screenHeight * .2,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Icon(Icons.edit),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Container(
                                                        height: 300.0,
                                                        // Change as per your requirement
                                                        width: 300.0,
                                                        // Change as per your requirement
                                                        child: Column(
                                                          children: [
                                                            snapshot.data!
                                                                        .interests ==
                                                                    null
                                                                ? CustomTextField(
                                                                    controller:
                                                                        textInterest1,
                                                                  )
                                                                : CustomTextField(
                                                                    initialValue: snapshot.data!.interests![0] ==
                                                                            null
                                                                        ? ""
                                                                        : snapshot
                                                                            .data!
                                                                            .interests![0],
                                                                    onChanged:
                                                                        (value) {
                                                                      snapshot
                                                                          .data!
                                                                          .interests![0] = value;
                                                                    },
                                                                  ),
                                                            snapshot.data!
                                                                        .interests ==
                                                                    null
                                                                ? CustomTextField(
                                                                    controller:
                                                                        textInterest2,
                                                                  )
                                                                : CustomTextField(
                                                                    initialValue: snapshot.data!.interests![1] ==
                                                                            null
                                                                        ? ""
                                                                        : snapshot
                                                                            .data!
                                                                            .interests![1],
                                                                    onChanged:
                                                                        (value) {
                                                                      snapshot
                                                                          .data!
                                                                          .interests![1] = value;
                                                                    },
                                                                  ),
                                                            snapshot.data!
                                                                        .interests ==
                                                                    null
                                                                ? CustomTextField(
                                                                    controller:
                                                                        textInterest3,
                                                                  )
                                                                : CustomTextField(
                                                                    initialValue: snapshot.data!.interests![2] ==
                                                                            null
                                                                        ? ""
                                                                        : snapshot
                                                                            .data!
                                                                            .interests![2],
                                                                    onChanged:
                                                                        (value) {
                                                                      snapshot
                                                                          .data!
                                                                          .interests![2] = value;
                                                                    },
                                                                  ),
                                                            TextButton(
                                                              onPressed: () {
                                                                // ContentController()
                                                                //     .updateData(
                                                                //         data: {
                                                                //       "data[0]": snapshot.data!.interests ==
                                                                //               null
                                                                //           ? textInterest1
                                                                //               .text
                                                                //           : snapshot
                                                                //               .data!
                                                                //               .interests![0],
                                                                //       "data[1]": snapshot.data!.interests ==
                                                                //               null
                                                                //           ? textInterest2
                                                                //               .text
                                                                //           : snapshot
                                                                //               .data!
                                                                //               .interests![1],
                                                                //       "data[2]": snapshot.data!.interests ==
                                                                //               null
                                                                //           ? textInterest3
                                                                //               .text
                                                                //           : snapshot
                                                                //               .data!
                                                                //               .interests![2],
                                                                //     },
                                                                //         modification:
                                                                //             'interests');
                                                              },
                                                              child:
                                                                  Text('حفظ'),
                                                            )
                                                          ],
                                                        )),
                                                  );
                                                });
                                          },
                                        ),
                                        Text('الاهتمامات ',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontFamily: 'Janna LT Regular',
                                                color: accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  snapshot.data!.interests == null
                                      ? SizedBox()
                                      : Expanded(
                                          child: ListView.builder(
                                            itemBuilder: (snap, index) {
                                              return Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          '${snapshot.data!.interests![index]}'),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: snapshot
                                                .data!.interests!.length,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        // bottomNavigationBar: CustomNavigationBar(
        //   index: 1,
        // ),
      ),
    );
  }
}
