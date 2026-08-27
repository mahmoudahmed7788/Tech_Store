import 'package:flutter/material.dart';

class AppStrings {
  static bool isArabic(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'ar';
  }

  static String get(
    BuildContext context, {
    required String en,
    required String ar,
  }) {
    return isArabic(context) ? ar : en;
  }

  // =========================================================
  // GENERAL
  // =========================================================

  static String appName(BuildContext context) =>
      get(context, en: 'Tech Store', ar: 'متجر تيك');

  static String save(BuildContext context) =>
      get(context, en: 'Save', ar: 'حفظ');

  static String cancel(BuildContext context) =>
      get(context, en: 'Cancel', ar: 'إلغاء');

  static String confirm(BuildContext context) =>
      get(context, en: 'Confirm', ar: 'تأكيد');

  static String delete(BuildContext context) =>
      get(context, en: 'Delete', ar: 'حذف');

  static String edit(BuildContext context) =>
      get(context, en: 'Edit', ar: 'تعديل');

  static String done(BuildContext context) =>
      get(context, en: 'Done', ar: 'تم');

  static String loading(BuildContext context) =>
      get(context, en: 'Loading...', ar: 'جاري التحميل...');

  static String error(BuildContext context) =>
      get(context, en: 'Something went wrong', ar: 'حدث خطأ ما');

  static String retry(BuildContext context) =>
      get(context, en: 'Retry', ar: 'إعادة المحاولة');

  // =========================================================
  // HOME
  // =========================================================

  static String home(BuildContext context) =>
      get(context, en: 'Home', ar: 'الرئيسية');

  static String greeting(BuildContext context) =>
      get(context, en: 'Welcome back,', ar: 'مرحباً بعودتك،');

  static String search(BuildContext context) =>
      get(context, en: 'Search', ar: 'بحث');

  static String searchProducts(BuildContext context) =>
      get(context, en: 'Search products...', ar: 'ابحث عن المنتجات...');

  static String products(BuildContext context) =>
      get(context, en: 'Products', ar: 'المنتجات');

  static String categories(BuildContext context) =>
      get(context, en: 'Categories', ar: 'الفئات');

  static String all(BuildContext context) =>
      get(context, en: 'All', ar: 'الكل');

  static String laptops(BuildContext context) =>
      get(context, en: 'Laptops', ar: 'أجهزة اللابتوب');

  static String smartphones(BuildContext context) =>
      get(context, en: 'Smartphones', ar: 'الهواتف الذكية');

  static String tablets(BuildContext context) =>
      get(context, en: 'Tablets', ar: 'الأجهزة اللوحية');

  static String accessories(BuildContext context) =>
      get(context, en: 'Accessories', ar: 'الإكسسوارات');

  static String gaming(BuildContext context) =>
      get(context, en: 'Gaming', ar: 'الألعاب');

  static String wearables(BuildContext context) =>
      get(context, en: 'Wearables', ar: 'الأجهزة القابلة للارتداء');

  static String noProducts(BuildContext context) =>
      get(context, en: 'No products found', ar: 'لم يتم العثور على منتجات');

  static String failedToLoadProducts(BuildContext context) =>
      get(
        context,
        en: 'Failed to load products',
        ar: 'فشل تحميل المنتجات',
      );

  // =========================================================
  // PRODUCT
  // =========================================================

  static String addToCart(BuildContext context) =>
      get(context, en: 'Add to Cart', ar: 'أضف إلى السلة');

  static String addedToCart(BuildContext context) =>
      get(context, en: 'Added to Cart', ar: 'تمت الإضافة إلى السلة');

  static String inCart(BuildContext context) =>
      get(context, en: 'In Cart', ar: 'في السلة');

  static String rating(BuildContext context) =>
      get(context, en: 'Rating', ar: 'التقييم');

  static String price(BuildContext context) =>
      get(context, en: 'Price', ar: 'السعر');

  // =========================================================
  // FAVORITES
  // =========================================================

  static String favorites(BuildContext context) =>
      get(context, en: 'Favorites', ar: 'المفضلة');

  static String noFavorites(BuildContext context) =>
      get(
        context,
        en: 'No favorite products yet',
        ar: 'لا توجد منتجات مفضلة حتى الآن',
      );

  static String favoriteEmpty(BuildContext context) =>
      get(
        context,
        en: 'Products you add to favorites will appear here.',
        ar: 'المنتجات التي تضيفها إلى المفضلة ستظهر هنا.',
      );

  // =========================================================
  // CART
  // =========================================================

  static String cart(BuildContext context) =>
      get(context, en: 'Cart', ar: 'السلة');

  static String yourCart(BuildContext context) =>
      get(context, en: 'Your Cart', ar: 'سلة التسوق');

  static String cartEmpty(BuildContext context) =>
      get(
        context,
        en: 'Your cart is empty',
        ar: 'سلة التسوق فارغة',
      );

  static String checkout(BuildContext context) =>
      get(context, en: 'Checkout', ar: 'إتمام الشراء');

  static String total(BuildContext context) =>
      get(context, en: 'Total', ar: 'الإجمالي');

  static String quantity(BuildContext context) =>
      get(context, en: 'Quantity', ar: 'الكمية');

  static String remove(BuildContext context) =>
      get(context, en: 'Remove', ar: 'حذف');

  // =========================================================
  // SETTINGS
  // =========================================================

  static String settings(BuildContext context) =>
      get(context, en: 'Settings', ar: 'الإعدادات');

  static String profile(BuildContext context) =>
      get(context, en: 'Profile', ar: 'الملف الشخصي');

  static String language(BuildContext context) =>
      get(context, en: 'Language', ar: 'اللغة');

  static String privacySecurity(BuildContext context) =>
      get(
        context,
        en: 'Privacy & Security',
        ar: 'الخصوصية والأمان',
      );

  static String notifications(BuildContext context) =>
      get(context, en: 'Notifications', ar: 'الإشعارات');

  static String help(BuildContext context) =>
      get(context, en: 'Help', ar: 'المساعدة');

  static String darkMode(BuildContext context) =>
      get(context, en: 'Dark Mode', ar: 'الوضع الداكن');

  static String lightMode(BuildContext context) =>
      get(context, en: 'Light Mode', ar: 'الوضع الفاتح');

  // =========================================================
  // SECURITY
  // =========================================================

  static String biometricLogin(BuildContext context) =>
      get(
        context,
        en: 'Biometric Login',
        ar: 'تسجيل الدخول بالبصمة',
      );

  static String twoFactor(BuildContext context) =>
      get(
        context,
        en: 'Two-Factor Authentication',
        ar: 'المصادقة الثنائية',
      );

  static String activeDevices(BuildContext context) =>
      get(
        context,
        en: 'Active Devices',
        ar: 'الأجهزة النشطة',
      );

  static String changePassword(BuildContext context) =>
      get(
        context,
        en: 'Change Password',
        ar: 'تغيير كلمة المرور',
      );

  static String biometricAvailable(BuildContext context) =>
      get(
        context,
        en: 'Biometric Login is available.',
        ar: 'تسجيل الدخول بالبصمة متاح.',
      );

  static String biometricUnavailable(BuildContext context) =>
      get(
        context,
        en: 'Biometric authentication is not available on this device.',
        ar: 'المصادقة بالبصمة غير متاحة على هذا الجهاز.',
      );

  static String twoFactorAvailable(BuildContext context) =>
      get(
        context,
        en: 'Two-Factor Authentication is available.',
        ar: 'المصادقة الثنائية متاحة.',
      );

  // =========================================================
  // 2FA
  // =========================================================

  static String protectAccount(BuildContext context) =>
      get(
        context,
        en: 'Protect your account',
        ar: 'احمِ حسابك',
      );

  static String twoFactorEnabled(BuildContext context) =>
      get(
        context,
        en: 'Two-Factor Authentication is Enabled',
        ar: 'المصادقة الثنائية مفعلة',
      );

  static String twoFactorDescription(BuildContext context) =>
      get(
        context,
        en: 'Your account is protected with an additional verification step.',
        ar: 'حسابك محمي بخطوة تحقق إضافية.',
      );

  static String twoFactorAddPhone(BuildContext context) =>
      get(
        context,
        en: 'Add your phone number to protect your account with an additional verification step.',
        ar: 'أضف رقم هاتفك لحماية حسابك بخطوة تحقق إضافية.',
      );

  static String phoneNumber(BuildContext context) =>
      get(context, en: 'Phone Number', ar: 'رقم الهاتف');

  static String verificationCode(BuildContext context) =>
      get(context, en: 'Verification Code', ar: 'رمز التحقق');

  static String enterOtp(BuildContext context) =>
      get(context, en: 'Enter OTP', ar: 'أدخل رمز التحقق');

  static String sendCode(BuildContext context) =>
      get(context, en: 'Send Code', ar: 'إرسال الرمز');

  static String verifyCode(BuildContext context) =>
      get(context, en: 'Verify Code', ar: 'تحقق من الرمز');

  static String disable2FA(BuildContext context) =>
      get(context, en: 'Disable 2FA', ar: 'إيقاف المصادقة الثنائية');

  static String phoneRequired(BuildContext context) =>
      get(
        context,
        en: 'Please enter your phone number',
        ar: 'من فضلك أدخل رقم هاتفك',
      );

  static String internationalPhone(BuildContext context) =>
      get(
        context,
        en: 'Use international format, example: +201xxxxxxxxx',
        ar: 'استخدم الصيغة الدولية، مثال: +201xxxxxxxxx',
      );

  static String codeSent(BuildContext context) =>
      get(
        context,
        en: 'Verification code sent',
        ar: 'تم إرسال رمز التحقق',
      );

  static String requestCodeFirst(BuildContext context) =>
      get(
        context,
        en: 'Please request a code first',
        ar: 'من فضلك اطلب رمز التحقق أولاً',
      );

  static String sixDigitCode(BuildContext context) =>
      get(
        context,
        en: 'Enter the 6-digit code',
        ar: 'أدخل رمز التحقق المكون من 6 أرقام',
      );

  static String noLoggedUser(BuildContext context) =>
      get(
        context,
        en: 'No logged in user',
        ar: 'لا يوجد مستخدم مسجل الدخول',
      );

  static String twoFactorEnabledMessage(BuildContext context) =>
      get(
        context,
        en: 'Two-Factor Authentication enabled',
        ar: 'تم تفعيل المصادقة الثنائية',
      );

  static String twoFactorDisabledMessage(BuildContext context) =>
      get(
        context,
        en: 'Two-Factor Authentication disabled',
        ar: 'تم إيقاف المصادقة الثنائية',
      );

  // =========================================================
  // LANGUAGE
  // =========================================================

  static String english(BuildContext context) =>
      get(context, en: 'English', ar: 'الإنجليزية');

  static String arabic(BuildContext context) =>
      get(context, en: 'Arabic', ar: 'العربية');

  // =========================================================
  // AUTH
  // =========================================================

  static String login(BuildContext context) =>
      get(context, en: 'Login', ar: 'تسجيل الدخول');

  static String register(BuildContext context) =>
      get(context, en: 'Register', ar: 'إنشاء حساب');

  static String email(BuildContext context) =>
      get(context, en: 'Email', ar: 'البريد الإلكتروني');

  static String password(BuildContext context) =>
      get(context, en: 'Password', ar: 'كلمة المرور');

  static String firstName(BuildContext context) =>
      get(context, en: 'First Name', ar: 'الاسم الأول');

  static String lastName(BuildContext context) =>
      get(context, en: 'Last Name', ar: 'اسم العائلة');

  static String phone(BuildContext context) =>
      get(context, en: 'Phone', ar: 'الهاتف');

  static String logout(BuildContext context) =>
      get(context, en: 'Logout', ar: 'تسجيل الخروج');
}
static String addToCart(BuildContext context) =>
    get(
      context,
      en: 'Add to Cart',
      ar: 'أضف إلى السلة',
    );

static String addedToCart(BuildContext context) =>
    get(
      context,
      en: 'Added to Cart',
      ar: 'تمت الإضافة إلى السلة',
    );

static String greeting(BuildContext context) =>
    get(
      context,
      en: 'Welcome back,',
      ar: 'مرحباً بعودتك،',
    );

static String searchProducts(BuildContext context) =>
    get(
      context,
      en: 'Search products...',
      ar: 'ابحث عن المنتجات...',
    );

static String all(BuildContext context) =>
    get(
      context,
      en: 'All',
      ar: 'الكل',
    );

static String laptops(BuildContext context) =>
    get(
      context,
      en: 'Laptops',
      ar: 'لابتوبات',
    );

static String smartphones(BuildContext context) =>
    get(
      context,
      en: 'Smartphones',
      ar: 'هواتف ذكية',
    );

static String tablets(BuildContext context) =>
    get(
      context,
      en: 'Tablets',
      ar: 'أجهزة لوحية',
    );

static String accessories(BuildContext context) =>
    get(
      context,
      en: 'Accessories',
      ar: 'إكسسوارات',
    );

static String gaming(BuildContext context) =>
    get(
      context,
      en: 'Gaming',
      ar: 'ألعاب',
    );

static String wearables(BuildContext context) =>
    get(
      context,
      en: 'Wearables',
      ar: 'أجهزة قابلة للارتداء',
    );

static String somethingWentWrong(BuildContext context) =>
    get(
      context,
      en: 'Something went wrong',
      ar: 'حدث خطأ ما',
    );

String noProducts(BuildContext context) =>
    get(
      context,
      en: 'No products found',
      ar: 'لم يتم العثور على منتجات',
    );