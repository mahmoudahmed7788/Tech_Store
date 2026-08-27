import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DeviceService {
  static final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  static final FirebaseAuth _auth =
      FirebaseAuth.instance;

  // ============================================================
  // REGISTER DEVICE
  // ============================================================

  static Future<void> registerDevice() async {
    final user = _auth.currentUser;

    if (user == null) {
      debugPrint('No user logged in.');
      return;
    }

    try {
      final deviceId = _getDeviceId();

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('devices')
          .doc(deviceId)
          .set(
        {
          'deviceId': deviceId,
          'email': user.email ?? '',
          'platform': _getPlatform(),
          'deviceName': _getDeviceName(),
          'current': true,
          'lastActive': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );

      debugPrint('========== DEVICE REGISTERED ==========');
      debugPrint('DEVICE ID: $deviceId');
    } catch (e) {
      debugPrint('========== DEVICE REGISTER ERROR ==========');
      debugPrint(e.toString());
    }
  }

  // ============================================================
  // DEVICE ID
  // ============================================================

  static String _getDeviceId() {
    if (kIsWeb) {
      return 'web_session';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'android_session';

      case TargetPlatform.iOS:
        return 'ios_session';

      case TargetPlatform.windows:
        return 'windows_session';

      case TargetPlatform.macOS:
        return 'macos_session';

      case TargetPlatform.linux:
        return 'linux_session';

      case TargetPlatform.fuchsia:
        return 'fuchsia_session';
    }
  }

  // ============================================================
  // DEVICE NAME
  // ============================================================

  static String _getDeviceName() {
    if (kIsWeb) {
      return 'Web Browser';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'Android Device';

      case TargetPlatform.iOS:
        return 'iPhone / iPad';

      case TargetPlatform.windows:
        return 'Windows PC';

      case TargetPlatform.macOS:
        return 'Mac';

      case TargetPlatform.linux:
        return 'Linux PC';

      case TargetPlatform.fuchsia:
        return 'Fuchsia Device';
    }
  }

  // ============================================================
  // PLATFORM
  // ============================================================

  static String _getPlatform() {
    if (kIsWeb) {
      return 'Web';
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return 'Android';

      case TargetPlatform.iOS:
        return 'iOS';

      case TargetPlatform.windows:
        return 'Windows';

      case TargetPlatform.macOS:
        return 'macOS';

      case TargetPlatform.linux:
        return 'Linux';

      case TargetPlatform.fuchsia:
        return 'Fuchsia';
    }
  }

  // ============================================================
  // GET DEVICES
  // ============================================================

  static Stream<QuerySnapshot<Map<String, dynamic>>>
      getDevices() {
    final user = _auth.currentUser;

    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .orderBy(
          'lastActive',
          descending: true,
        )
        .snapshots();
  }

  // ============================================================
  // REMOVE DEVICE
  // ============================================================

  static Future<void> removeDevice(
    String deviceId,
  ) async {
    final user = _auth.currentUser;

    if (user == null) return;

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .doc(deviceId)
        .delete();
  }

  // ============================================================
  // UPDATE LAST ACTIVE
  // ============================================================

  static Future<void> updateLastActive() async {
    final user = _auth.currentUser;

    if (user == null) return;

    final deviceId = _getDeviceId();

    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('devices')
        .doc(deviceId)
        .set(
      {
        'lastActive': FieldValue.serverTimestamp(),
        'current': true,
      },
      SetOptions(merge: true),
    );
  }
}