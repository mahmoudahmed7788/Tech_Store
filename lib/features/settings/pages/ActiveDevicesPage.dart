import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tech_store/core/constsnts/DeviceService.dart';


class ActiveDevicesPage extends StatelessWidget {
  const ActiveDevicesPage({super.key});

  Future<void> _removeDevice(
    BuildContext context,
    String deviceId,
  ) async {
    try {
      await DeviceService.removeDevice(deviceId);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Device removed successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not remove device'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text('Active Devices'),
        ),
        body: const Center(
          child: Text(
            'No user is logged in',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Active Devices',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: StreamBuilder<
          QuerySnapshot<Map<String, dynamic>>>(
        stream: DeviceService.getDevices(),

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4C5DFF),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Error loading devices:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            );
          }

          final devices =
              snapshot.data?.docs ?? [];

          if (devices.isEmpty) {
            return const Center(
              child: Text(
                'No active devices found',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(20),

            children: [
              const SizedBox(height: 10),

              const Icon(
                Icons.devices_outlined,
                color: Color(0xFF4C5DFF),
                size: 75,
              ),

              const SizedBox(height: 15),

              const Text(
                'Your Active Devices',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                '${devices.length} device${devices.length == 1 ? '' : 's'} connected',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              ...devices.map(
                (device) {
                  final data = device.data();

                  final String deviceName =
                      data['deviceName'] ??
                          'Unknown Device';

                  final String platform =
                      data['platform'] ??
                          'Unknown';

                  final String email =
                      data['email'] ??
                          user.email ??
                          '';

                  final bool current =
                      data['current'] ??
                          false;

                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 14,
                    ),

                    padding:
                        const EdgeInsets.all(16),

                    decoration:
                        BoxDecoration(
                      color:
                          const Color(0xFF1A1A1A),
                      borderRadius:
                          BorderRadius.circular(16),
                    ),

                    child: Row(
                      children: [
                        Container(
                          width: 55,
                          height: 55,

                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                              0xFF4C5DFF,
                            ).withOpacity(0.15),
                            borderRadius:
                                BorderRadius.circular(
                              14,
                            ),
                          ),

                          child: Icon(
                            platform == 'Android'
                                ? Icons.phone_android
                                : Icons.devices,
                            color:
                                const Color(
                              0xFF4C5DFF,
                            ),
                            size: 30,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [
                              Text(
                                deviceName,
                                style:
                                    const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                platform,
                                style:
                                    const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 3),

                              Text(
                                email,
                                maxLines: 1,
                                overflow:
                                    TextOverflow.ellipsis,
                                style:
                                    const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 7),

                              Row(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 9,
                                    color: current
                                        ? Colors.green
                                        : Colors.grey,
                                  ),

                                  const SizedBox(
                                    width: 6,
                                  ),

                                  Text(
                                    current
                                        ? 'Current Device'
                                        : 'Active Device',
                                    style:
                                        TextStyle(
                                      color: current
                                          ? Colors.green
                                          : Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {
                            _showDeleteDialog(
                              context,
                              device.id,
                              deviceName,
                            );
                          },

                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    String deviceId,
    String deviceName,
  ) {
    showDialog(
      context: context,

      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF1A1A1A),

          title: const Text(
            'Remove Device?',
            style: TextStyle(
              color: Colors.white,
            ),
          ),

          content: Text(
            'Remove $deviceName from your active devices?',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext);

                await _removeDevice(
                  context,
                  deviceId,
                );
              },

              child: const Text(
                'Remove',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}