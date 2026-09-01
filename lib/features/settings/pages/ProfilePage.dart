import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';
import 'package:tech_store/features/settings/Widgets/Profile/ProfileTitle.dart';

import 'package:tech_store/features/settings/widgets/profile/ProfileHeader.dart';
import 'package:tech_store/features/settings/widgets/profile/ProfilePasswordField.dart';

class ProfilePage extends StatefulWidget {
  final String userName;

  const ProfilePage({
    super.key,
    required this.userName,
  });

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {
  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final TextEditingController
      nameController =
      TextEditingController();

  final TextEditingController
      emailController =
      TextEditingController();

  final TextEditingController
      phoneController =
      TextEditingController();

  String? newPassword;

  bool isSaving = false;

  // =========================================================
  // INIT
  // =========================================================

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

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.white;

    return Scaffold(
      backgroundColor:
          theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor:
            theme.scaffoldBackgroundColor,

        foregroundColor:
            textColor,

        elevation: 0,

        title: Text(
          AppStrings.profile(context),
          style: const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            ProfileHeader(
              userName:
                  nameController.text,
            ),

            // =================================================
            // NAME
            // =================================================

            ProfileTile(
              icon:
                  Icons.person_outline,

              title:
                  AppStrings.firstName(
                context,
              ),

              value:
                  nameController.text.isEmpty
                      ? AppStrings
                          .addYourName(
                          context,
                        )
                      : nameController.text,

              onTap:
                  _changeName,
            ),

            // =================================================
            // EMAIL
            // =================================================

            ProfileTile(
              icon:
                  Icons.email_outlined,

              title:
                  AppStrings.email(
                context,
              ),

              value:
                  emailController.text.isEmpty
                      ? AppStrings
                          .addYourEmail(
                          context,
                        )
                      : emailController.text,

              onTap:
                  _changeEmail,
            ),

            // =================================================
            // PHONE
            // =================================================

            ProfileTile(
              icon:
                  Icons.phone_outlined,

              title:
                  AppStrings.phone(
                context,
              ),

              value:
                  phoneController.text.isEmpty
                      ? AppStrings
                          .addYourPhone(
                          context,
                        )
                      : phoneController.text,

              onTap:
                  _changePhone,
            ),

            // =================================================
            // PASSWORD
            // =================================================

            ProfileTile(
              icon:
                  Icons.lock_outline,

              title:
                  AppStrings.password(
                context,
              ),

              value:
                  '••••••••',

              onTap:
                  _changePassword,
            ),

            const SizedBox(
              height: 30,
            ),

            // =================================================
            // SAVE
            // =================================================

            SizedBox(
              width:
                  double.infinity,

              height: 55,

              child:
                  ElevatedButton(
                onPressed:
                    isSaving
                        ? null
                        : _saveChanges,

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryBlue,

                  foregroundColor:
                      Colors.white,

                  elevation: 0,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                      14,
                    ),
                  ),
                ),

                child:
                    isSaving
                        ? const SizedBox(
                            width: 23,
                            height: 23,
                            child:
                                CircularProgressIndicator(
                              strokeWidth:
                                  2.5,
                              color:
                                  Colors.white,
                            ),
                          )
                        : Text(
                            AppStrings
                                .saveChanges(
                              context,
                            ),
                            style:
                                const TextStyle(
                              fontSize: 17,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
              ),
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // CHANGE NAME
  // =========================================================

  void _changeName() {
    final controller =
        TextEditingController(
      text: nameController.text,
    );

    showDialog(
      context: context,

      builder:
          (dialogContext) {
        return AlertDialog(
          title: Text(
            AppStrings.changeName(
              context,
            ),
          ),

          content:
              TextField(
            controller:
                controller,

            autofocus: true,

            decoration:
                InputDecoration(
              labelText:
                  AppStrings.firstName(
                context,
              ),

              prefixIcon:
                  const Icon(
                Icons.person_outline,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child: Text(
                AppStrings.cancel(
                  context,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final name =
                    controller.text.trim();

                if (name.isEmpty) {
                  _showMessage(
                    AppStrings
                        .nameCannotBeEmpty(
                      context,
                    ),
                  );
                  return;
                }

                setState(() {
                  nameController.text =
                      name;
                });

                Navigator.pop(
                  dialogContext,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    primaryBlue,
                foregroundColor:
                    Colors.white,
              ),

              child: Text(
                AppStrings.done(
                  context,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CHANGE EMAIL
  // =========================================================

  void _changeEmail() {
    final controller =
        TextEditingController(
      text: emailController.text,
    );

    showDialog(
      context: context,

      builder:
          (dialogContext) {
        return AlertDialog(
          title: Text(
            AppStrings.changeEmail(
              context,
            ),
          ),

          content:
              TextField(
            controller:
                controller,

            autofocus: true,

            keyboardType:
                TextInputType
                    .emailAddress,

            decoration:
                InputDecoration(
              labelText:
                  AppStrings.email(
                context,
              ),

              prefixIcon:
                  const Icon(
                Icons.email_outlined,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child: Text(
                AppStrings.cancel(
                  context,
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
                    AppStrings
                        .enterValidEmail(
                      context,
                    ),
                  );
                  return;
                }

                setState(() {
                  emailController.text =
                      email;
                });

                Navigator.pop(
                  dialogContext,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    primaryBlue,
                foregroundColor:
                    Colors.white,
              ),

              child: Text(
                AppStrings.done(
                  context,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CHANGE PHONE
  // =========================================================

  void _changePhone() {
    final controller =
        TextEditingController(
      text: phoneController.text,
    );

    showDialog(
      context: context,

      builder:
          (dialogContext) {
        return AlertDialog(
          title: Text(
            AppStrings.changePhone(
              context,
            ),
          ),

          content:
              TextField(
            controller:
                controller,

            autofocus: true,

            keyboardType:
                TextInputType.phone,

            decoration:
                InputDecoration(
              labelText:
                  AppStrings.phoneNumber(
                context,
              ),

              hintText:
                  AppStrings.phoneHint(
                context,
              ),

              prefixIcon:
                  const Icon(
                Icons.phone_outlined,
              ),
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },

              child: Text(
                AppStrings.cancel(
                  context,
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                final phone =
                    controller.text.trim();

                if (phone.isEmpty) {
                  _showMessage(
                    AppStrings
                        .phoneCannotBeEmpty(
                      context,
                    ),
                  );
                  return;
                }

                setState(() {
                  phoneController.text =
                      phone;
                });

                Navigator.pop(
                  dialogContext,
                );
              },

              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    primaryBlue,
                foregroundColor:
                    Colors.white,
              ),

              child: Text(
                AppStrings.done(
                  context,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // =========================================================
  // CHANGE PASSWORD
  // =========================================================

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

      builder:
          (dialogContext) {
        return StatefulBuilder(
          builder:
              (
            context,
            setDialogState,
          ) {
            return AlertDialog(
              title: Text(
                AppStrings
                    .changePasswordTitle(
                  context,
                ),
              ),

              content:
                  SingleChildScrollView(
                child: Column(
                  mainAxisSize:
                      MainAxisSize.min,

                  children: [
                    ProfilePasswordField(
                      controller:
                          currentController,

                      label:
                          AppStrings
                              .currentPassword(
                        context,
                      ),

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

                    ProfilePasswordField(
                      controller:
                          newController,

                      label:
                          AppStrings
                              .newPassword(
                        context,
                      ),

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

                    ProfilePasswordField(
                      controller:
                          confirmController,

                      label:
                          AppStrings
                              .confirmPassword(
                        context,
                      ),

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

                  child: Text(
                    AppStrings.cancel(
                      context,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () async {
                    final current =
                        currentController
                            .text
                            .trim();

                    final password =
                        newController
                            .text
                            .trim();

                    final confirm =
                        confirmController
                            .text
                            .trim();

                    if (current.isEmpty ||
                        password.isEmpty ||
                        confirm.isEmpty) {
                      _showMessage(
                        AppStrings
                            .pleaseFillAllFields(
                          context,
                        ),
                      );
                      return;
                    }

                    if (password.length <
                        6) {
                      _showMessage(
                        AppStrings
                            .passwordMinLength(
                          context,
                        ),
                      );
                      return;
                    }

                    if (password !=
                        confirm) {
                      _showMessage(
                        AppStrings
                            .passwordsDoNotMatch(
                          context,
                        ),
                      );
                      return;
                    }

                    if (password ==
                        current) {
                      _showMessage(
                        AppStrings
                            .newPasswordDifferent(
                          context,
                        ),
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
                          AppStrings
                              .noLoggedUser(
                            context,
                          ),
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
                        newPassword =
                            password;
                      });

                      Navigator.pop(
                        dialogContext,
                      );

                      _showMessage(
                        AppStrings
                            .passwordReadyToSave(
                          context,
                        ),
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
                        primaryBlue,
                    foregroundColor:
                        Colors.white,
                  ),

                  child: Text(
                    AppStrings.done(
                      context,
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

  // =========================================================
  // SAVE CHANGES
  // =========================================================

  Future<void> _saveChanges() async {
    final user =
        _auth.currentUser;

    if (user == null) {
      _showMessage(
        AppStrings.noLoggedUser(
          context,
        ),
      );
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      // NAME
      final newName =
          nameController.text.trim();

      if (newName.isNotEmpty &&
          newName !=
              user.displayName) {
        await user.updateDisplayName(
          newName,
        );
      }

      // PASSWORD
      if (newPassword != null &&
          newPassword!.isNotEmpty) {
        await user.updatePassword(
          newPassword!,
        );
      }

      // EMAIL
      final newEmail =
          emailController.text.trim();

      if (newEmail.isNotEmpty &&
          newEmail != user.email) {
        await user
            .verifyBeforeUpdateEmail(
          newEmail,
        );
      }

      await user.reload();

      if (!mounted) return;

      setState(() {
        isSaving = false;
        newPassword = null;
      });

      _showMessage(
        AppStrings
            .changesSavedSuccessfully(
          context,
        ),
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
        AppStrings.error(
          context,
        ),
      );
    }
  }

  // =========================================================
  // FIREBASE ERROR
  // =========================================================

  void _showFirebaseError(
    FirebaseAuthException e,
  ) {
    String message;

    switch (e.code) {
      case 'wrong-password':
      case 'invalid-credential':
        message =
            AppStrings
                .currentPasswordIncorrect(
          context,
        );
        break;

      case 'email-already-in-use':
        message =
            AppStrings.emailAlreadyInUse(
          context,
        );
        break;

      case 'invalid-email':
        message =
            AppStrings.invalidEmailAddress(
          context,
        );
        break;

      case 'weak-password':
        message =
            AppStrings.passwordTooWeak(
          context,
        );
        break;

      case 'requires-recent-login':
        message =
            AppStrings.pleaseLoginAgain(
          context,
        );
        break;

      case 'network-request-failed':
        message =
            AppStrings
                .checkInternetConnection(
          context,
        );
        break;

      default:
        message =
            AppStrings.error(
          context,
        );
    }

    _showMessage(message);
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _showMessage(
    String message,
  ) {
    if (!mounted) return;

    ScaffoldMessenger
        .of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger
        .of(context)
        .showSnackBar(
      SnackBar(
        content:
            Text(message),

        backgroundColor:
            Theme.of(context)
                .cardColor,
      ),
    );
  }
}