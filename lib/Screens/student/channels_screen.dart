import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/constants.dart';
import 'package:e_learning/Screens/celebrity/store/video_story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({Key? key}) : super(key: key);

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> channels = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    loadChannels();
  }

  Future<void> loadChannels() async {
    isLoading.value = true;
    try {
      var firestoreChannels = await _firebaseService.getCollection('celebs');
      if (firestoreChannels.isNotEmpty) {
        channels.assignAll(firestoreChannels);
      } else {
        // Fallback demo channels if Firestore is empty
        channels.assignAll([
          {
            'name': 'د. أحمد الشريف',
            'occupation': 'خبير البرمجة وتطوير الويب',
            'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=500&auto=format&fit=crop',
            'bio': 'أستاذ علوم الحاسب وتطوير البرمجيات بخبرة أكثر من 10 سنوات.',
          },
          {
            'name': 'م. سارة علي',
            'occupation': 'مهندسة واجهات المستخدم UI/UX',
            'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=500&auto=format&fit=crop',
            'bio': 'متخصصة في تصميم التجارب الرقمية وتطبيقات الموبايل الحديثة.',
          },
          {
            'name': 'أ. محمد عبد الله',
            'occupation': 'خبير الذكاء الاصطناعي',
            'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=500&auto=format&fit=crop',
            'bio': 'باحث في تقنيات الذكاء الاصطناعي وتعلم الآلة.',
          },
        ]);
      }
    } catch (e) {
      print("Error loading channels: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "قنوات المؤثرين والمعلمين",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            fontFamily: 'Janna LT Regular',
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (isLoading.value) {
          return const Center(child: GlobalLoading());
        }

        if (channels.isEmpty) {
          return Center(
            child: Text(
              "لا توجد قنوات متاحة حالياً",
              style: TextStyle(
                fontFamily: 'Janna LT Regular',
                fontSize: 15.sp,
                color: Colors.grey,
              ),
            ),
          );
        }

        return RefreshIndicator(
          color: primaryColor,
          onRefresh: loadChannels,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            itemCount: channels.length,
            itemBuilder: (context, index) {
              final channel = channels[index];
              return Container(
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12.w),
                    leading: CircleAvatar(
                      radius: 36.r,
                      backgroundColor: Colors.blue.shade50,
                      backgroundImage: channel['image'] != null && channel['image'].toString().isNotEmpty
                          ? NetworkImage(channel['image'])
                          : const AssetImage('assets/biz.png') as ImageProvider,
                    ),
                    title: Text(
                      channel['name'] ?? channel['fullname'] ?? "معلم بايزين",
                      style: TextStyle(
                        fontFamily: 'Janna LT Regular',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 3.h),
                        Text(
                          channel['occupation'] ?? channel['email'] ?? "",
                          style: TextStyle(
                            fontFamily: 'Janna LT Regular',
                            fontSize: 11.sp,
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          channel['bio'] ?? "قناة تعليمية متخصصة في تقديم أحدث الدروس والدورات.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Janna LT Regular',
                            fontSize: 10.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 14.sp, color: primaryColor.withOpacity(0.6)),
                    onTap: () {
                      Get.to(() => CreatorProfilePage(channelData: channel));
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class CreatorProfilePage extends StatelessWidget {
  final Map<String, dynamic> channelData;
  CreatorProfilePage({Key? key, required this.channelData}) : super(key: key);

  // Sample Playlists for the creator
  final List<Map<String, dynamic>> playlists = [
    {
      'title': 'قائمة تشغيل: أساسيات البرمجة بلغة جافا',
      'videosCount': 5,
      'image': 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=500',
      'videos': [
        {'title': 'الدرس 1: مقدمة في لغة جافا', 'duration': '12:30'},
        {'title': 'الدرس 2: المتغيرات وأنواع البيانات', 'duration': '18:45'},
        {'title': 'الدرس 3: الجمل الشرطية If/Else', 'duration': '14:20'},
        {'title': 'الدرس 4: الحلقات التكرارية Loops', 'duration': '20:10'},
        {'title': 'الدرس 5: الدوال Methods', 'duration': '16:55'},
      ],
    },
    {
      'title': 'قائمة تشغيل: تطوير تطبيقات الموبايل بـ Flutter',
      'videosCount': 4,
      'image': 'https://images.unsplash.com/photo-1526374965328-7f61d4dc18c5?q=80&w=500',
      'videos': [
        {'title': 'الدرس 1: مقدمة فلاتر ودارت', 'duration': '15:00'},
        {'title': 'الدرس 2: تصميم الواجهات StatelessWidget', 'duration': '22:15'},
        {'title': 'الدرس 3: إدارة الحالة StateManagement', 'duration': '25:30'},
        {'title': 'الدرس 4: ربط التطبيق بالـ API', 'duration': '30:00'},
      ],
    },
    {
      'title': 'قائمة تشغيل: تصميم واجهات المستخدم UI/UX',
      'videosCount': 3,
      'image': 'https://images.unsplash.com/photo-1581291518633-83b4ebd1d83e?q=80&w=500',
      'videos': [
        {'title': 'الدرس 1: مبادئ وأساسيات تصميم UI', 'duration': '18:00'},
        {'title': 'الدرس 2: نظرية الألوان والخطوط', 'duration': '16:20'},
        {'title': 'الدرس 3: إنشاء نموذج تجريبي Prototype', 'duration': '24:10'},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          channelData['name'] ?? channelData['fullname'] ?? "قناة المعلم",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            fontFamily: 'Janna LT Regular',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    primaryColor.withOpacity(0.12),
                    primaryColor.withOpacity(0.02),
                    Colors.white,
                  ],
                ),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: Colors.white,
                        backgroundImage: channelData['image'] != null && channelData['image'].toString().isNotEmpty
                            ? NetworkImage(channelData['image'])
                            : const AssetImage('assets/biz.png') as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified, color: Colors.white, size: 14),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    channelData['name'] ?? channelData['fullname'] ?? "معلم بايزين",
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Janna LT Regular',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Text(
                    channelData['occupation'] ?? "خبير تعليمي",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Janna LT Regular',
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    channelData['bio'] ?? "قناة تعليمية متخصصة في تقديم أحدث الدروس والدورات.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey.shade600,
                      fontFamily: 'Janna LT Regular',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "قوائم التشغيل (Playlists)",
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'Janna LT Regular',
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                final playlist = playlists[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.r),
                      onTap: () {
                        Get.to(() => PlaylistVideosScreen(playlistData: playlist));
                      },
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                playlist['image'],
                                width: 65.w,
                                height: 65.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    playlist['title'],
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Janna LT Regular',
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Row(
                                    children: [
                                      Icon(Icons.video_library_outlined, size: 13.sp, color: primaryColor),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "${playlist['videosCount']} فيديوهات تعليمية",
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          color: primaryColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Janna LT Regular',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey.shade400),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistVideosScreen extends StatelessWidget {
  final Map<String, dynamic> playlistData;
  const PlaylistVideosScreen({Key? key, required this.playlistData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List videos = playlistData['videos'] ?? [];
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          playlistData['title'],
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            fontFamily: 'Janna LT Regular',
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.assignment_turned_in_outlined, color: primaryColor),
            tooltip: 'امتحان المنهج الشامل',
            onPressed: () {
              Get.to(() => QuizScreen(
                    title: "الامتحان الشامل: ${playlistData['title']}",
                    questions: [
                      {
                        'question': 'ما هو الهدف الأساسي من دراسة هذا المنهج أو قائمة التشغيل؟',
                        'options': ['إتقان المهارات العملية بتمكن', 'حفظ النظريات فقط', 'اجتياز الوقت', 'لا يوجد هدف'],
                        'answerIndex': 0,
                      },
                      {
                        'question': 'أي من التالي يُعتبر أفضل ممارسة عند كتابة البرمجيات؟',
                        'options': ['تكرار الكود', 'تنظيم الكود وكتابة تعليقات واضحة', 'تجاهل الأخطاء', 'إهمال الهيكلة'],
                        'answerIndex': 1,
                      },
                      {
                        'question': 'كيف تتعامل مع الأخطاء والمشاكل البرمجية أثناء التطوير؟',
                        'options': ['حذف التطبيق', 'فهم رسالة الخطأ والبحث عن الحل', 'تجاهلها تماماً', 'إغلاق الجهاز'],
                        'answerIndex': 1,
                      },
                      {
                        'question': 'ما هي أهمية تطبيق المشاريع العملية في نهاية المنهج؟',
                        'options': ['ترسيخ المعلومات وبناء الخبرة العملية', 'إضاعة الوقت', 'ليست لها أي أهمية', 'زيادة حجم الملفات'],
                        'answerIndex': 0,
                      },
                      {
                        'question': 'هل يُنصح بالاستمرار في ممارسة وتطوير المشاريع بعد إتمام المنهج؟',
                        'options': ['لا، التوقف أفضل', 'نعم، الاستمرار يصقل المهارات ويطورها', 'فقط مرة واحدة', 'غير مهم'],
                        'answerIndex': 1,
                      },
                    ],
                  ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16.r),
                onTap: () {
                  Get.to(() => StudentVideoPlayerScreen(videoData: video));
                },
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Row(
                    children: [
                      Container(
                        width: 75.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          image: DecorationImage(
                            image: NetworkImage(playlistData['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video['title'],
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Janna LT Regular',
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(Icons.access_time_rounded, size: 12.sp, color: Colors.grey.shade400),
                                SizedBox(width: 4.w),
                                Text(
                                  video['duration'],
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey.shade500,
                                    fontFamily: 'Janna LT Regular',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class StudentVideoPlayerScreen extends StatelessWidget {
  final Map<String, dynamic> videoData;
  const StudentVideoPlayerScreen({Key? key, required this.videoData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String title = videoData['title'] ?? 'شرح الدرس';
    final String duration = videoData['duration'] ?? '10:00';
    final String actualVideoUrl = videoData['url'] ?? 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            fontFamily: 'Janna LT Regular',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.black,
              child: VideoStory(
                videoUrl: actualVideoUrl,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Janna LT Regular',
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.access_time_rounded, size: 14.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        "المدة: $duration",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                          fontFamily: 'Janna LT Regular',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "وصف الدرس",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Janna LT Regular',
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          "هذا الدرس يشرح المفاهيم الأساسية والتطبيقات العمليّة خطوة بخطوة لضمان الفهم الكامل للمحتوى التعليمي.",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                            fontFamily: 'Janna LT Regular',
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: primaryColor, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => QuizScreen(
                              title: "اختبار الفيديو: $title",
                              questions: [
                                {
                                  'question': 'ما هي الفكرة الرئيسية التي تم شرحها في هذا الدرس؟',
                                  'options': ['فهم الأساسيات والمفاهيم', 'كتابة كود عشوائي', 'لا توجد فكرة رئيسية', 'تجاهل التطبيق'],
                                  'answerIndex': 0,
                                },
                                {
                                  'question': 'كيف يمكن تطبيق ما تعلمته في هذا الفيديو؟',
                                  'options': ['من خلال التطبيق العملي', 'بقراءة العنوان فقط', 'لا يمكن تطبيقه', 'حفظ الكود نظرياً'],
                                  'answerIndex': 0,
                                },
                                {
                                  'question': 'هل يعتبر هذا الدرس أساسياً لفهم الدروس القادمة؟',
                                  'options': ['لا أهمية له', 'نعم، هو حجر الأساس', 'اختياري تماماً', 'غير مرتبط بالمنهج'],
                                  'answerIndex': 1,
                                },
                              ],
                            ));
                      },
                      icon: Icon(Icons.quiz_outlined, color: primaryColor),
                      label: Text(
                        "اختبار قصير على هذا الفيديو",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontFamily: 'Janna LT Regular',
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> questions;

  const QuizScreen({Key? key, required this.title, required this.questions}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentIndex = 0;
  int score = 0;
  int? selectedOption;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    final questions = widget.questions;
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: const Center(child: Text("لا توجد أسئلة متاحة لهذا الاختبار حالياً.")),
      );
    }

    final q = questions[currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            fontFamily: 'Janna LT Regular',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: isSubmitted
            ? Center(
                child: Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(score >= (questions.length / 2) ? Icons.emoji_events : Icons.school, size: 60.sp, color: primaryColor),
                      SizedBox(height: 16.h),
                      Text(
                        score >= (questions.length / 2) ? "أحسنت! لقد اجتزت الاختبار بنجاح" : "حاول مرة أخرى",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "النتيجة: $score من ${questions.length}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: 'Janna LT Regular',
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      SizedBox(
                        width: double.infinity,
                        height: 48.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "تم",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontFamily: 'Janna LT Regular',
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "السؤال ${currentIndex + 1} من ${questions.length}",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.grey.shade500,
                        ),
                      ),
                      Text(
                        "${((currentIndex + 1) / questions.length * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'Janna LT Regular',
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  LinearProgressIndicator(
                    value: (currentIndex + 1) / questions.length,
                    backgroundColor: Colors.grey.shade200,
                    color: primaryColor,
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      q['question'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Janna LT Regular',
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: (q['options'] as List).length,
                      itemBuilder: (context, optIndex) {
                        final optionText = q['options'][optIndex];
                        final isSelected = selectedOption == optIndex;
                        return Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                          decoration: BoxDecoration(
                            color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
                            border: Border.all(
                              color: isSelected ? primaryColor : Colors.grey.shade200,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: RadioListTile<int>(
                            title: Text(
                              optionText,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Janna LT Regular',
                                color: Colors.black87,
                              ),
                            ),
                            value: optIndex,
                            groupValue: selectedOption,
                            activeColor: primaryColor,
                            onChanged: (val) {
                              setState(() {
                                selectedOption = val;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: selectedOption == null
                          ? null
                          : () {
                              if (selectedOption == q['answerIndex']) {
                                score++;
                              }
                              if (currentIndex < questions.length - 1) {
                                setState(() {
                                  currentIndex++;
                                  selectedOption = null;
                                });
                              } else {
                                setState(() {
                                  isSubmitted = true;
                                });
                              }
                            },
                      child: Text(
                        currentIndex < questions.length - 1 ? "السؤال التالي" : "إنهاء الاختبار",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontFamily: 'Janna LT Regular',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
