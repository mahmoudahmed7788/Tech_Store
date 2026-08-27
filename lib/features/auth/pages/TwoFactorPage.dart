import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tech_store/core/constsnts/AppStrings.dart';

class TwoFactorPage extends StatefulWidget {
  const TwoFactorPage({
    super.key,
  });

  @override
  State<TwoFactorPage> createState() =>
      _TwoFactorPageState();
}

class _TwoFactorPageState
    extends State<TwoFactorPage> {
  static const Color primaryBlue =
      Color(0xFF4C5DFF);

  final FirebaseAuth _auth =
      FirebaseAuth.instance;

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController codeController =
      TextEditingController();

  String? verificationId;

  bool codeSent = false;
  bool loading = false;
  bool enabled = false;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();

    _checkTwoFactor();
  }

  // ============================================================
  // CHECK 2FA
  // ============================================================

  Future<void> _checkTwoFactor() async {
    final user = _auth.currentUser;

    if (user == null) {
      return;
    }

    try {
      final factors =
          await user.multiFactor
              .getEnrolledFactors();

      if (!mounted) return;

      setState(() {
        enabled = factors.isNotEmpty;
      });
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      _showMessage(
        e.message ??
            AppStrings.error(context),
      );
    } catch (e) {
      if (!mounted) return;

      _showMessage(
        AppStrings.error(context),
      );
    }
  }

  // ============================================================
  // SEND OTP
  // ============================================================

  Future<void> _sendCode() async {
    final phone =
        phoneController.text.trim();

    if (phone.isEmpty) {
      _showMessage(
        AppStrings.phoneRequired(context),
      );

      return;
    }

    if (!phone.startsWith('+')) {
      _showMessage(
        AppStrings.internationalPhone(context),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,

        verificationCompleted:
            (PhoneAuthCredential credential) {},

        verificationFailed:
            (FirebaseAuthException e) {
          if (!mounted) return;

          setState(() {
            loading = false;
          });

          _showMessage(
            e.message ??
                AppStrings.error(context),
          );
        },

        codeSent:
            (String id, int? resendToken) {
          if (!mounted) return;

          setState(() {
            verificationId = id;
            codeSent = true;
            loading = false;
          });

          _showMessage(
            AppStrings.codeSent(context),
          );
        },

        codeAutoRetrievalTimeout:
            (String id) {
          verificationId = id;
        },
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(
        AppStrings.error(context),
      );
    }
  }

  // ============================================================
  // VERIFY OTP
  // ============================================================

  Future<void> _verifyCode() async {
    final code =
        codeController.text.trim();

    if (verificationId == null) {
      _showMessage(
        AppStrings.requestCodeFirst(context),
      );

      return;
    }

    if (code.length != 6) {
      _showMessage(
        AppStrings.sixDigitCode(context),
      );

      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final phoneCredential =
          PhoneAuthProvider.credential(
        verificationId:
            verificationId!,
        smsCode: code,
      );

      final assertion =
          PhoneMultiFactorGenerator
              .getAssertion(
        phoneCredential,
      );

      final user =
          _auth.currentUser;

      if (user == null) {
        if (!mounted) return;

        setState(() {
          loading = false;
        });

        _showMessage(
          AppStrings.noLoggedUser(context),
        );

        return;
      }

      await user.multiFactor.enroll(
        assertion,
        displayName:
            AppStrings.phoneNumber(context),
      );

      if (!mounted) return;

      setState(() {
        enabled = true;
        loading = false;
      });

      _showMessage(
        AppStrings.twoFactorEnabledMessage(
          context,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(
        e.message ??
            AppStrings.error(context),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(
        AppStrings.error(context),
      );
    }
  }

  // ============================================================
  // DISABLE 2FA
  // ============================================================

  Future<void> _disableTwoFactor() async {
    final user =
        _auth.currentUser;

    if (user == null) {
      _showMessage(
        AppStrings.noLoggedUser(context),
      );

      return;
    }

    try {
      final factors =
          await user.multiFactor
              .getEnrolledFactors();

      if (factors.isEmpty) {
        if (!mounted) return;

        setState(() {
          enabled = false;
        });

        _showMessage(
          AppStrings.get(
            context,
            en: 'Two-Factor Authentication is not enabled',
            ar: 'المصادقة الثنائية غير مفعلة',
          ),
        );

        return;
      }

      if (!mounted) return;

      setState(() {
        loading = true;
      });

      await user.multiFactor.unenroll(
        multiFactorInfo:
            factors.first,
      );

      if (!mounted) return;

      setState(() {
        enabled = false;
        loading = false;
        codeSent = false;
        verificationId = null;
        codeController.clear();
      });

      _showMessage(
        AppStrings.twoFactorDisabledMessage(
          context,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(
        e.message ??
            AppStrings.error(context),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        loading = false;
      });

      _showMessage(
        AppStrings.error(context),
      );
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message,
  ) {
    if (!mounted) return;

    final theme =
        Theme.of(context);

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            theme.colorScheme.inverseSurface,
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
  }) {
    final theme =
        Theme.of(context);

    return InputDecoration(
      hintText: hint,

      hintStyle: TextStyle(
        color: theme
            .textTheme
            .bodySmall
            ?.color
            ?.withOpacity(0.55),
      ),

      labelText: label,

      labelStyle: TextStyle(
        color: theme
            .textTheme
            .bodySmall
            ?.color,
      ),

      prefixIcon: Icon(
        icon,
        color:
            theme.iconTheme.color,
      ),

      filled: true,

      fillColor:
          theme.cardColor,

      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            BorderSide(
          color:
              theme.dividerColor,
        ),
      ),

      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),

        borderSide:
            const BorderSide(
          color: primaryBlue,
          width: 1.5,
        ),
      ),

      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme =
        Theme.of(context);

    final textColor =
        theme.textTheme.bodyLarge?.color ??
            Colors.black;

    final secondaryColor =
        theme.textTheme.bodyMedium
                ?.color
                ?.withOpacity(0.65) ??
            Colors.grey;

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
          AppStrings.twoFactor(context),

          style: TextStyle(
            color: textColor,
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
            const SizedBox(height: 30),

            // ==================================================
            // ICON
            // ==================================================

            const Icon(
              Icons.verified_user_outlined,
              color: primaryBlue,
              size: 90,
            ),

            const SizedBox(height: 25),

            // ==================================================
            // TITLE
            // ==================================================

            Text(
              enabled
                  ? AppStrings.twoFactorEnabled(
                      context,
                    )
                  : AppStrings.protectAccount(
                      context,
                    ),

              textAlign:
                  TextAlign.center,

              style: TextStyle(
                color: textColor,
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // ==================================================
            // DESCRIPTION
            // ==================================================

            Text(
              enabled
                  ? AppStrings.twoFactorDescription(
                      context,
                    )
                  : AppStrings.twoFactorAddPhone(
                      context,
                    ),

              textAlign:
                  TextAlign.center,

              style: TextStyle(
                color:
                    secondaryColor,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 35),

            // ==================================================
            // ENABLE 2FA
            // ==================================================

            if (!enabled) ...[
              TextField(
                controller:
                    phoneController,

                keyboardType:
                    TextInputType.phone,

                style: TextStyle(
                  color: textColor,
                ),

                decoration:
                    _inputDecoration(
                  context,

                  label:
                      AppStrings.phoneNumber(
                    context,
                  ),

                  hint:
                      '+201xxxxxxxxx',

                  icon:
                      Icons.phone,
                ),
              ),

              const SizedBox(height: 20),

              // =================================================
              // OTP
              // =================================================

              if (codeSent)
                TextField(
                  controller:
                      codeController,

                  keyboardType:
                      TextInputType.number,

                  maxLength: 6,

                  style: TextStyle(
                    color: textColor,
                  ),

                  decoration:
                      _inputDecoration(
                    context,

                    label:
                        AppStrings.verificationCode(
                      context,
                    ),

                    hint:
                        AppStrings.enterOtp(
                      context,
                    ),

                    icon:
                        Icons.sms_outlined,
                  ),
                ),

              if (codeSent)
                const SizedBox(
                  height: 15,
                ),

              // =================================================
              // SEND / VERIFY
              // =================================================

              SizedBox(
                width:
                    double.infinity,

                height: 55,

                child:
                    ElevatedButton(
                  onPressed:
                      loading
                          ? null
                          : codeSent
                              ? _verifyCode
                              : _sendCode,

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

                  child: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              CircularProgressIndicator(
                            color:
                                Colors.white,
                            strokeWidth:
                                2.5,
                          ),
                        )
                      : Text(
                          codeSent
                              ? AppStrings.verifyCode(
                                  context,
                                )
                              : AppStrings.sendCode(
                                  context,
                                ),

                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize:
                                17,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ]

            // ==================================================
            // DISABLE 2FA
            // ==================================================

            else ...[
              SizedBox(
                width:
                    double.infinity,

                height: 55,

                child:
                    ElevatedButton(
                  onPressed:
                      loading
                          ? null
                          : _disableTwoFactor,

                  style:
                      ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red,

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

                  child: loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child:
                              CircularProgressIndicator(
                            color:
                                Colors.white,
                            strokeWidth:
                                2.5,
                          ),
                        )
                      : Text(
                          AppStrings.disable2FA(
                            context,
                          ),

                          style:
                              const TextStyle(
                            color:
                                Colors.white,
                            fontSize:
                                17,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    phoneController.dispose();
    codeController.dispose();

    super.dispose();
  }
}
