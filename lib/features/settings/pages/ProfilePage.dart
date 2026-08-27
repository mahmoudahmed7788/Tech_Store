import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userName;

  const ProfilePage({
    super.key,
    required this.userName,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= CONTROLLERS =================

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  // ================= VARIABLES =================

  String? newPassword;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    final user = _auth.currentUser;

    nameController.text =
        user?.displayName?.isNotEmpty == true
            ? user!.displayName!
            : widget.userName;

    emailController.text =
        user?.email ?? '';

    phoneController.text =
        user?.phoneNumber ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,

        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            const SizedBox(height: 20),

            // =================================================
            // AVATAR
            // =================================================

            const CircleAvatar(
              radius: 55,

              backgroundColor:
                  Color(0xFF4C5DFF),

              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),

            const SizedBox(height: 20),

            // =================================================
            // NAME
            // =================================================

            Text(
              nameController.text.isEmpty
                  ? 'User'
                  : nameController.text,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 35),

            // =================================================
            // NAME
            // =================================================

            _profileTile(
              icon: Icons.person_outline,
              title: 'Name',

              value:
                  nameController.text.isEmpty
                      ? 'Add your name'
                      : nameController.text,

              onTap: _changeName,
            ),

            // =================================================
            // EMAIL
            // =================================================

            _profileTile(
              icon: Icons.email_outlined,
              title: 'Email',

              value:
                  emailController.text.isEmpty
                      ? 'Add your email'
                      : emailController.text,

              onTap: _changeEmail,
            ),

            // =================================================
            // PHONE
            // =================================================

            _profileTile(
              icon: Icons.phone_outlined,
              title: 'Phone',

              value:
                  phoneController.text.isEmpty
                      ? 'Add your phone'
                      : phoneController.text,

              onTap: _changePhone,
            ),

            // =================================================
            // PASSWORD
            // =================================================

            _profileTile(
              icon: Icons.lock_outline,
              title: 'Password',
              value: '••••••••',
              onTap: _changePassword,
            ),

            const SizedBox(height: 30),

            // =================================================
            // SAVE CHANGES
            // =================================================

            SizedBox(
              width: double.infinity,
              height: 55,

              child: ElevatedButton(
                onPressed:
                    isSaving
                        ? null
                        : _saveChanges,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF4C5DFF),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(14),
                  ),
                ),

                child:
                    isSaving
                        ? const SizedBox(
                            width: 23,
                            height: 23,

                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Save Changes',

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PROFILE TILE
  // ============================================================

  Widget _profileTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      decoration:
          BoxDecoration(
        color:
            const Color(0xFF1A1A1A),

        borderRadius:
            BorderRadius.circular(14),
      ),

      child: ListTile(
        onTap: onTap,

        leading: Icon(
          icon,
          color: Colors.white,
        ),

        title: Text(
          title,

          style:
              const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),

        subtitle: Text(
          value,

          style:
              const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),

        trailing:
            const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 17,
        ),
      ),
    );
  }

  // ============================================================
  // CHANGE NAME
  // ============================================================

  void _changeName() {
    final controller =
        TextEditingController(
      text: nameController.text,
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF1A1A1A),

          title: const Text(
            'Change Name',

            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: TextField(
            controller: controller,
            autofocus: true,

            style:
                const TextStyle(
              color: Colors.white,
            ),

            decoration:
                InputDecoration(
              labelText: 'Name',

              labelStyle:
                  const TextStyle(
                color: Colors.grey,
              ),

              prefixIcon:
                  const Icon(
                Icons.person_outline,
                color: Colors.grey,
              ),

              enabledBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                borderSide:
                    const BorderSide(
                  color: Colors.grey,
                ),
              ),

              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                borderSide:
                    const BorderSide(
                  color:
                      Color(0xFF4C5DFF),
                ),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Cancel',

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final name =
                    controller.text.trim();

                if (name.isEmpty) {
                  _showMessage(
                    'Name cannot be empty',
                  );
                  return;
                }

                setState(() {
                  nameController.text =
                      name;
                });

                Navigator.pop(
                  context,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF4C5DFF,
                ),
              ),

              child: const Text(
                'Done',

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CHANGE EMAIL
  // ============================================================

  void _changeEmail() {
    final controller =
        TextEditingController(
      text: emailController.text,
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF1A1A1A),

          title: const Text(
            'Change Email',

            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: TextField(
            controller: controller,
            autofocus: true,

            keyboardType:
                TextInputType.emailAddress,

            style:
                const TextStyle(
              color: Colors.white,
            ),

            decoration:
                InputDecoration(
              labelText: 'Email',

              labelStyle:
                  const TextStyle(
                color: Colors.grey,
              ),

              prefixIcon:
                  const Icon(
                Icons.email_outlined,
                color: Colors.grey,
              ),

              enabledBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                borderSide:
                    const BorderSide(
                  color: Colors.grey,
                ),
              ),

              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                borderSide:
                    const BorderSide(
                  color:
                      Color(0xFF4C5DFF),
                ),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Cancel',

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final email =
                    controller.text.trim();

                if (email.isEmpty ||
                    !email.contains('@')) {
                  _showMessage(
                    'Enter a valid email',
                  );
                  return;
                }

                setState(() {
                  emailController.text =
                      email;
                });

                Navigator.pop(
                  context,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF4C5DFF,
                ),
              ),

              child: const Text(
                'Done',

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CHANGE PHONE
  // ============================================================

  void _changePhone() {
    final controller =
        TextEditingController(
      text: phoneController.text,
    );

    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          backgroundColor:
              const Color(0xFF1A1A1A),

          title: const Text(
            'Change Phone',

            style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          content: TextField(
            controller: controller,
            autofocus: true,

            keyboardType:
                TextInputType.phone,

            style:
                const TextStyle(
              color: Colors.white,
            ),

            decoration:
                InputDecoration(
              labelText:
                  'Phone Number',

              labelStyle:
                  const TextStyle(
                color: Colors.grey,
              ),

              prefixIcon:
                  const Icon(
                Icons.phone_outlined,
                color: Colors.grey,
              ),

              hintText:
                  '+20xxxxxxxxxx',

              hintStyle:
                  const TextStyle(
                color: Colors.grey,
              ),

              enabledBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                borderSide:
                    const BorderSide(
                  color: Colors.grey,
                ),
              ),

              focusedBorder:
                  OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),

                borderSide:
                    const BorderSide(
                  color:
                      Color(0xFF4C5DFF),
                ),
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                );
              },

              child: const Text(
                'Cancel',

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final phone =
                    controller.text.trim();

                if (phone.isEmpty) {
                  _showMessage(
                    'Phone cannot be empty',
                  );
                  return;
                }

                setState(() {
                  phoneController.text =
                      phone;
                });

                Navigator.pop(
                  context,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF4C5DFF,
                ),
              ),

              child: const Text(
                'Done',

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // CHANGE PASSWORD
  // ============================================================

  void _changePassword() {
    final currentController =
        TextEditingController();

    final newController =
        TextEditingController();

    final confirmController =
        TextEditingController();

    bool obscureCurrent = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (dialogContext) {
        return StatefulBuilder(
          builder:
              (
                context,
                setDialogState,
              ) {
            return AlertDialog(
              backgroundColor:
                  const Color(
                0xFF1A1A1A,
              ),

              title: const Text(
                'Change Password',

                style: TextStyle(
                  color: Colors.white,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              content:
                  SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [
                    _passwordField(
                      controller:
                          currentController,

                      label:
                          'Current Password',

                      obscure:
                          obscureCurrent,

                      onEyePressed: () {
                        setDialogState(() {
                          obscureCurrent =
                              !obscureCurrent;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    _passwordField(
                      controller:
                          newController,

                      label:
                          'New Password',

                      obscure:
                          obscureNew,

                      onEyePressed: () {
                        setDialogState(() {
                          obscureNew =
                              !obscureNew;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    _passwordField(
                      controller:
                          confirmController,

                      label:
                          'Confirm Password',

                      obscure:
                          obscureConfirm,

                      onEyePressed: () {
                        setDialogState(() {
                          obscureConfirm =
                              !obscureConfirm;
                        });
                      },
                    ),
                  ],
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },

                  child: const Text(
                    'Cancel',

                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    final current =
                        currentController
                            .text
                            .trim();

                    final newPassword =
                        newController
                            .text
                            .trim();

                    final confirm =
                        confirmController
                            .text
                            .trim();

                    if (current.isEmpty ||
                        newPassword.isEmpty ||
                        confirm.isEmpty) {
                      _showMessage(
                        'Please fill all fields',
                      );
                      return;
                    }

                    if (newPassword.length <
                        6) {
                      _showMessage(
                        'Password must be at least 6 characters',
                      );
                      return;
                    }

                    if (newPassword !=
                        confirm) {
                      _showMessage(
                        'Passwords do not match',
                      );
                      return;
                    }

                    if (newPassword ==
                        current) {
                      _showMessage(
                        'New password must be different',
                      );
                      return;
                    }

                    try {
                      final user =
                          _auth.currentUser;

                      if (user == null ||
                          user.email ==
                              null) {
                        _showMessage(
                          'No logged in user',
                        );
                        return;
                      }

                      final credential =
                          EmailAuthProvider
                              .credential(
                        email:
                            user.email!,
                        password:
                            current,
                      );

                      await user
                          .reauthenticateWithCredential(
                        credential,
                      );

                      setState(() {
                        this.newPassword =
                            newPassword;
                      });

                      Navigator.pop(
                        dialogContext,
                      );

                      _showMessage(
                        'Password ready to save',
                      );
                    } on FirebaseAuthException catch (
                        e) {
                      _showFirebaseError(
                        e,
                      );
                    }
                  },

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF4C5DFF,
                    ),
                  ),

                  child: const Text(
                    'Done',

                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ============================================================
  // PASSWORD FIELD
  // ============================================================

  Widget _passwordField({
    required TextEditingController
        controller,

    required String label,

    required bool obscure,

    required VoidCallback
        onEyePressed,
  }) {
    return TextField(
      controller: controller,

      obscureText: obscure,

      style:
          const TextStyle(
        color: Colors.white,
      ),

      decoration:
          InputDecoration(
        labelText: label,

        labelStyle:
            const TextStyle(
          color: Colors.grey,
        ),

        prefixIcon:
            const Icon(
          Icons.lock_outline,
          color: Colors.grey,
        ),

        suffixIcon:
            IconButton(
          onPressed:
              onEyePressed,

          icon: Icon(
            obscure
                ? Icons.visibility
                : Icons.visibility_off,

            color:
                Colors.grey,
          ),
        ),

        enabledBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),

          borderSide:
              const BorderSide(
            color: Colors.grey,
          ),
        ),

        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),

          borderSide:
              const BorderSide(
            color:
                Color(0xFF4C5DFF),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SAVE CHANGES
  // ============================================================

  Future<void> _saveChanges() async {
    final user =
        _auth.currentUser;

    if (user == null) {
      _showMessage(
        'No logged in user',
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      // ================= NAME =================

      final newName =
          nameController.text.trim();

      if (newName.isNotEmpty &&
          newName !=
              user.displayName) {
        await user.updateDisplayName(
          newName,
        );
      }

      // ================= PASSWORD =================

      if (newPassword != null &&
          newPassword!.isNotEmpty) {
        await user.updatePassword(
          newPassword!,
        );
      }

      // ================= EMAIL =================

      final newEmail =
          emailController.text.trim();

      if (newEmail.isNotEmpty &&
          newEmail != user.email) {
        await user
            .verifyBeforeUpdateEmail(
          newEmail,
        );
      }

      // ================= RELOAD =================

      await user.reload();

      if (!mounted) return;

      setState(() {
        isSaving = false;
        newPassword = null;
      });

      _showMessage(
        'Changes saved successfully',
      );
    } on FirebaseAuthException catch (
        e) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      _showFirebaseError(e);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      _showMessage(
        'Something went wrong',
      );
    }
  }

  // ============================================================
  // FIREBASE ERROR
  // ============================================================

  void _showFirebaseError(
    FirebaseAuthException e,
  ) {
    String message;

    switch (e.code) {
      case 'wrong-password':
      case 'invalid-credential':
        message =
            'Current password is incorrect';
        break;

      case 'email-already-in-use':
        message =
            'This email is already in use';
        break;

      case 'invalid-email':
        message =
            'Invalid email address';
        break;

      case 'weak-password':
        message =
            'Password is too weak';
        break;

      case 'requires-recent-login':
        message =
            'Please login again and try again';
        break;

      case 'network-request-failed':
        message =
            'Check your internet connection';
        break;

      default:
        message =
            e.message ??
                'Something went wrong';
    }

    _showMessage(
      message,
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),

        backgroundColor:
            const Color(
          0xFF1A1A1A,
        ),
      ),
    );
  }
}