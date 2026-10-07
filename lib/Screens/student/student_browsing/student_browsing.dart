import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_learning/Screens/celebrity/browsing/model/celeb_browse.dart';
import 'package:e_learning/Screens/celebrity/browsing/profile_browsing.dart';
import 'package:e_learning/core/Services/firebase_service.dart';
import 'package:e_learning/core/global/globalloading.dart';
import 'package:e_learning/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class StudentBrowsing extends StatefulWidget {
  final String? programTitle;
  final int? programId;

  const StudentBrowsing({Key? key, this.programId, this.programTitle})
      : super(key: key);

  @override
  _StudentBrowsingState createState() => _StudentBrowsingState();
}

class _StudentBrowsingState extends State<StudentBrowsing> {
  final FirebaseService _firebaseService = FirebaseService();
  TextEditingController searchController = TextEditingController();
  RxBool isLoading = true.obs;
  RxList<Map<String, dynamic>> allCelebs = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> filteredCelebs = <Map<String, dynamic>>[].obs;

  @override
  void initState() {
    super.initState();
    loadCelebs();
  }

  Future<void> loadCelebs() async {
    isLoading.value = true;
    try {
      var celebsList = await _firebaseService.getCollection('celebs');
      if (celebsList.isNotEmpty) {
        allCelebs.assignAll(celebsList);
      } else {
        // Fallback rich demo creators
        allCelebs.assignAll([
          {
            'id': 1,
            'name': 'د. أحمد الشريف',
            'spec': 'خبير البرمجة وتطوير الويب',
            'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=500&auto=format&fit=crop',
            'bio': 'أستاذ علوم الحاسب وتطوير البرمجيات بخبرة أكثر من 10 سنوات.',
          },
          {
            'id': 2,
            'name': 'م. سارة علي',
            'spec': 'مهندسة واجهات المستخدم UI/UX',
            'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=500&auto=format&fit=crop',
            'bio': 'متخصصة في تصميم التجارب الرقمية وتطبيقات الموبايل الحديثة.',
          },
          {
            'id': 3,
            'name': 'أ. محمد عبد الله',
            'spec': 'خبير الذكاء الاصطناعي',
            'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=500&auto=format&fit=crop',
            'bio': 'باحث في تقنيات الذكاء الاصطناعي وتعلم الآلة.',
          },
          {
            'id': 4,
            'name': 'د. فاطمة الزهراء',
            'spec': 'أستاذة قواعد البيانات وData Science',
            'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=500&auto=format&fit=crop',
            'bio': 'متخصصة في تحليل البيانات وضخامة المعلومات.',
          },
        ]);
      }
      filteredCelebs.assignAll(allCelebs);
    } catch (e) {
      print("Error loading celebs: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void filterSearch(String query) {
    if (query.trim().isEmpty) {
      filteredCelebs.assignAll(allCelebs);
    } else {
      filteredCelebs.assignAll(
        allCelebs.where((celeb) =>
            (celeb['name'] ?? celeb['fullname'] ?? "").toString().toLowerCase().contains(query.toLowerCase()) ||
            (celeb['spec'] ?? celeb['occupation'] ?? "").toString().toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'المؤثرين والمعلمين',
          style: TextStyle(
            fontSize: 16.sp,
            fontFamily: 'Janna LT Regular',
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Modern Search Bar
            Container(
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
              child: TextField(
                controller: searchController,
                onChanged: filterSearch,
                decoration: InputDecoration(
                  hintText: "بحث بالاسم أو التخصص...",
                  hintStyle: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'Janna LT Regular',
                    color: Colors.grey.shade400,
                  ),
                  prefixIcon: const Icon(Icons.search, color: primaryColor, size: 20),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey, size: 18),
                          onPressed: () {
                            searchController.clear();
                            filterSearch('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: Obx(() {
                if (isLoading.value) {
                  return const Center(child: GlobalLoading());
                }

                if (filteredCelebs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_search_outlined, size: 50.sp, color: Colors.grey.shade400),
                        SizedBox(height: 10.h),
                        Text(
                          "لا يوجد أشخاص مطابقين للبحث",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontFamily: 'Janna LT Regular',
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: primaryColor,
                  onRefresh: loadCelebs,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: filteredCelebs.length,
                    itemBuilder: (context, index) {
                      final item = filteredCelebs[index];
                      final name = item['name'] ?? item['fullname'] ?? "معلم بايزين";
                      final spec = item['spec'] ?? item['occupation'] ?? "خبير تعليمي";
                      final image = item['image'] ?? "";

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
                              Get.to(() => ProfileBrowsingPage(
                                    celebId: item['id'] ?? 1,
                                  ));
                            },
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 28.r,
                                    backgroundColor: primaryColor.withOpacity(0.08),
                                    backgroundImage: image.isNotEmpty
                                        ? NetworkImage(image)
                                        : const AssetImage('assets/user.png') as ImageProvider,
                                  ),
                                  SizedBox(width: 14.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontFamily: 'Janna LT Regular',
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 3.h),
                                        Text(
                                          spec,
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontFamily: 'Janna LT Regular',
                                            fontWeight: FontWeight.w600,
                                            color: primaryColor,
                                          ),
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
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
