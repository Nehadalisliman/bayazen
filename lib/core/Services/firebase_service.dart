import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseService extends GetxService {
  FirebaseAuth? get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (_) {
      return null;
    }
  }

  FirebaseFirestore? get _firestore {
    try {
      return FirebaseFirestore.instance;
    } catch (_) {
      return null;
    }
  }

  // Get current user safely
  User? get currentUser {
    try {
      return _auth?.currentUser;
    } catch (_) {
      return null;
    }
  }

  // Sign in with email and password safely
  Future<User?> signIn(String email, String password) async {
    try {
      if (_auth == null) return null;
      UserCredential credential = await _auth!.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      try {
        if (_auth == null || _firestore == null) return null;
        UserCredential credential = await _auth!.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String userType = (email.contains('teacher') || email.contains('celeb')) ? 'celeb' : 'student';
        String collection = userType == 'celeb' ? 'celebs' : 'students';
        Map<String, dynamic> userData = {
          'uid': credential.user!.uid,
          'email': email,
          'password': password,
          'type': userType,
          'fullname': userType == 'celeb' ? 'د. أحمد الشريف (معلم)' : 'أحمد محمد',
          'createdAt': FieldValue.serverTimestamp(),
        };
        await _firestore!.collection(collection).doc(credential.user!.uid).set(userData, SetOptions(merge: true));
        await _firestore!.collection('users').doc(credential.user!.uid).set(userData, SetOptions(merge: true));
        return credential.user;
      } catch (createErr) {
        print("Auto-create user error: $createErr");
      }
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth?.signOut();
    } catch (_) {}
  }

  // Firestore generic getter for collection safely
  Future<List<Map<String, dynamic>>> getCollection(String collectionName) async {
    try {
      if (_firestore == null) return [];
      QuerySnapshot snapshot = await _firestore!.collection(collectionName).get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();
    } catch (e) {
      print("Error getting collection $collectionName: $e");
      return [];
    }
  }

  // Firestore get single document safely
  Future<Map<String, dynamic>?> getDocument(String collectionName, String docId) async {
    try {
      if (_firestore == null) return null;
      DocumentSnapshot doc = await _firestore!.collection(collectionName).doc(docId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }
      return null;
    } catch (e) {
      print("Error getting document $docId from $collectionName: $e");
      return null;
    }
  }

  // Firestore save/set document with specific ID safely
  Future<void> saveDocument(String collectionName, String docId, Map<String, dynamic> data) async {
    try {
      if (_firestore == null) return;
      await _firestore!.collection(collectionName).doc(docId).set({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error saving document in $collectionName: $e");
    }
  }

  // Firestore add document with auto-generated ID safely
  Future<String?> addDocument(String collectionName, Map<String, dynamic> data) async {
    try {
      if (_firestore == null) return null;
      DocumentReference docRef = await _firestore!.collection(collectionName).add({
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      });
      return docRef.id;
    } catch (e) {
      print("Error adding document to $collectionName: $e");
      return null;
    }
  }

  // Firestore update document safely
  Future<void> updateDocument(String collectionName, String docId, Map<String, dynamic> data) async {
    try {
      if (_firestore == null) return;
      await _firestore!.collection(collectionName).doc(docId).update({
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error updating document $docId in $collectionName: $e");
    }
  }

  // Firestore delete document safely
  Future<void> deleteDocument(String collectionName, String docId) async {
    try {
      if (_firestore == null) return;
      await _firestore!.collection(collectionName).doc(docId).delete();
    } catch (e) {
      print("Error deleting document $docId from $collectionName: $e");
    }
  }

  // Register / sign up with email, password, collection and extra data safely
  Future<User?> register(String email, String password, String collection, Map<String, dynamic> extraData) async {
    try {
      if (_auth == null || _firestore == null) return null;
      UserCredential credential = await _auth!.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Map<String, dynamic> userData = {
        'uid': credential.user!.uid,
        'email': email,
        'password': password,
        ...extraData,
        'createdAt': FieldValue.serverTimestamp(),
      };
      await _firestore!.collection(collection).doc(credential.user!.uid).set(userData, SetOptions(merge: true));
      await _firestore!.collection('users').doc(credential.user!.uid).set(userData, SetOptions(merge: true));
      return credential.user;
    } catch (e) {
      print("Error registering user: $e");
      Get.snackbar("خطأ في التسجيل", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return null;
    }
  }

  // Initialize all required collections in Firestore safely
  Future<void> initializeCollections() async {
    try {
      if (_firestore == null) return;

      var celebsQuery = await _firestore!.collection('celebs').limit(1).get();
      if (celebsQuery.docs.isEmpty) {
        List<Map<String, dynamic>> initialCelebs = [
          {
            'id': 1,
            'name': 'د. أحمد الشريف',
            'fullname': 'د. أحمد الشريف',
            'email': 'teacher@gmail.com',
            'password': '123456',
            'phone': '01099887766',
            'type': 'celeb',
            'specialization': 'هندسة البرمجيات وعلوم الحاسب',
            'occupation': 'خبير البرمجة وتطوير الويب',
            'bio': 'أستاذ علوم الحاسب وتطوير البرمجيات بخبرة أكثر من 10 سنوات.',
            'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=500',
            'createdAt': FieldValue.serverTimestamp(),
          },
          {
            'id': 2,
            'name': 'م. ساره علي',
            'fullname': 'م. ساره علي',
            'email': 'sara@gmail.com',
            'password': '123456',
            'phone': '01011223344',
            'type': 'celeb',
            'specialization': 'تصميم وتجربة المستخدم',
            'occupation': 'مهندسة واجهات المستخدم UI/UX',
            'bio': 'متخصصة في تصميم التجارب الرقمية وتطبيقات الموبايل الحديثة.',
            'image': 'https://images.unsplash.com/photo-1517841905240-472988babdf9?q=80&w=500',
            'createdAt': FieldValue.serverTimestamp(),
          },
          {
            'id': 3,
            'name': 'أ. محمد عبد الله',
            'fullname': 'أ. محمد عبد الله',
            'email': 'mohamed@gmail.com',
            'password': '123456',
            'phone': '01055667788',
            'type': 'celeb',
            'specialization': 'الذكاء الاصطناعي وتعلم الآلة',
            'occupation': 'خبير الذكاء الاصطناعي',
            'bio': 'باحث في تقنيات الذكاء الاصطناعي وتعلم الآلة.',
            'image': 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=500',
            'createdAt': FieldValue.serverTimestamp(),
          },
        ];
        for (var celeb in initialCelebs) {
          await _firestore!.collection('celebs').add(celeb);
          await _firestore!.collection('users').add(celeb);
        }
      }

      var studentsQuery = await _firestore!.collection('students').limit(1).get();
      if (studentsQuery.docs.isEmpty) {
        List<Map<String, dynamic>> initialStudents = [
          {
            'id': 1,
            'fullname': 'أحمد محمد',
            'email': 'student@gmail.com',
            'password': '123456',
            'phone': '01021426699',
            'type': 'student',
            'occupation': 'طالب علم وتكنولوجيا',
            'bio': 'مهتم بالتعلم وتطوير المهارات البرمجية وتصميم التطبيقات.',
            'image': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?q=80&w=500',
            'createdAt': FieldValue.serverTimestamp(),
          },
          {
            'id': 2,
            'fullname': 'محمود علي',
            'email': 'mahmoud@gmail.com',
            'password': '123456',
            'phone': '01122334455',
            'type': 'student',
            'occupation': 'طالب تكنولوجيا المعلومات',
            'bio': 'أسعى لتعلم تقنيات الويب والموبايل وبناء تطبيقات مميزة.',
            'image': 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?q=80&w=500',
            'createdAt': FieldValue.serverTimestamp(),
          },
        ];
        for (var student in initialStudents) {
          await _firestore!.collection('students').add(student);
          await _firestore!.collection('users').add(student);
        }
      }

      List<String> collections = [
        'users',
        'students',
        'courses',
        'categories',
        'chapters',
        'videos',
        'libraries',
        'stories',
        'comments',
        'payments'
      ];
      for (String col in collections) {
        if (col == 'celebs' || col == 'students') continue;
        var query = await _firestore!.collection(col).limit(1).get();
        if (query.docs.isEmpty) {
          await _firestore!.collection(col).add({
            'initialized': true,
            'message': 'Initial document for $col collection',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      print("Error initializing collections: $e");
    }
  }
}
