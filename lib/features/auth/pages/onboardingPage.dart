
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  int currentPage = 0;

  static const Color primaryBlue = Color(0xFF4C5DFF);

  final List<Map<String, dynamic>> pages = [
    {
      'image': 'assets/image/First.png',
      'line1': 'Welcome to',
      'titleSpans': [
        {'text': 'Tech ', 'color': Colors.white},
        {'text': 'Store', 'color': primaryBlue},
      ],
      'description':
          'Your one-stop destination for the latest tech and accessories.',
    },
    {
      'image': 'assets/image/second.png',
      'line1': 'Explore',
      'titleSpans': [
        {'text': 'Top ', 'color': primaryBlue},
        {'text': 'Products', 'color': Colors.white},
      ],
      'description':
          'Browse a wide range of quality tech products from top brands.',
    },
    {
      'image': 'assets/image/third.png',
      'line1': 'Easy & Secure',
      'titleSpans': [
        {'text': 'Shopping', 'color': primaryBlue},
      ],
      'description':
          'Enjoy a smooth, secure and fast shopping experience.',
    },
  ];

  // =========================================================
  // GO TO REGISTER
  // =========================================================

  void _goToRegister() {
    if (!mounted) return;

    context.go('/register');
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final bool isLastPage =
        currentPage == pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // SKIP BUTTON
            // =================================================

            Padding(
              padding: const EdgeInsets.only(
                right: 20,
                top: 4,
              ),

              child: Align(
                alignment: Alignment.topRight,

                child: Opacity(
                  opacity: isLastPage ? 0 : 1,

                  child: IgnorePointer(
                    ignoring: isLastPage,

                    child: TextButton(
                      onPressed: _goToRegister,

                      style: TextButton.styleFrom(
                        foregroundColor:
                            Colors.white70,

                        padding: EdgeInsets.zero,

                        minimumSize:
                            const Size(0, 0),

                        tapTargetSize:
                            MaterialTapTargetSize
                                .shrinkWrap,
                      ),

                      child: const Text(
                        'Skip',

                        style: TextStyle(
                          fontSize: 16,

                          fontWeight:
                              FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // =================================================
            // PAGE VIEW
            // =================================================

            Expanded(
              child: PageView.builder(
                controller: pageController,

                itemCount: pages.length,

                onPageChanged: (index) {
                  if (!mounted) return;

                  setState(() {
                    currentPage = index;
                  });
                },

                itemBuilder:
                    (context, index) {
                  final page =
                      pages[index];

                  final List<
                          Map<String, dynamic>>
                      titleSpans =
                      List<
                          Map<String,
                              dynamic>>.from(
                    page['titleSpans'],
                  );

                  return Padding(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 24,
                    ),

                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .center,

                      children: [
                        // =====================================
                        // IMAGE
                        // =====================================

                        Image.asset(
                          page['image'],

                          height: 340,

                          width:
                              double.infinity,

                          fit:
                              BoxFit.contain,
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        // =====================================
                        // LINE 1
                        // =====================================

                        Align(
                          alignment:
                              Alignment.centerLeft,

                          child: Text(
                            page['line1'],

                            style:
                                const TextStyle(
                              color:
                                  Colors.white,

                              fontSize: 26,

                              fontWeight:
                                  FontWeight.w400,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 4,
                        ),

                        // =====================================
                        // TITLE
                        // =====================================

                        Align(
                          alignment:
                              Alignment.centerLeft,

                          child: RichText(
                            text: TextSpan(
                              children:
                                  titleSpans
                                      .map(
                                (span) {
                                  return TextSpan(
                                    text:
                                        span['text'],

                                    style:
                                        TextStyle(
                                      color:
                                          span['color'],

                                      fontSize:
                                          32,

                                      fontWeight:
                                          FontWeight
                                              .bold,

                                      height:
                                          1.2,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        // =====================================
                        // DESCRIPTION
                        // =====================================

                        Align(
                          alignment:
                              Alignment.centerLeft,

                          child: Text(
                            page[
                                'description'],

                            style:
                                const TextStyle(
                              color: Color(
                                0xFFB0B0B0,
                              ),

                              fontSize: 15,

                              fontWeight:
                                  FontWeight.w400,

                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // =================================================
            // DOTS
            // =================================================

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              children:
                  List.generate(
                pages.length,
                (index) {
                  final bool isActive =
                      currentPage == index;

                  return AnimatedContainer(
                    duration:
                        const Duration(
                      milliseconds: 300,
                    ),

                    margin:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 4,
                    ),

                    height: 8,

                    width: 8,

                    decoration:
                        BoxDecoration(
                      color: isActive
                          ? primaryBlue
                          : const Color(
                              0xFF3A3A3A,
                            ),

                      shape:
                          BoxShape.circle,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            // =================================================
            // NEXT BUTTON
            // =================================================

            Padding(
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 24,
              ),

              child: SizedBox(
                width:
                    double.infinity,

                height: 56,

                child: ElevatedButton(
                  style:
                      ElevatedButton
                          .styleFrom(
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

                  onPressed: () {
                    if (isLastPage) {
                      _goToRegister();
                    } else {
                      pageController
                          .nextPage(
                        duration:
                            const Duration(
                          milliseconds:
                              350,
                        ),

                        curve:
                            Curves.easeInOut,
                      );
                    }
                  },

                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                    children: [
                      Text(
                        isLastPage
                            ? 'Get Started'
                            : 'Next',

                        style:
                            const TextStyle(
                          fontSize: 17,

                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),

                      if (!isLastPage) ...[
                        const SizedBox(
                          width: 10,
                        ),

                        const Icon(
                          Icons.arrow_forward,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }
}

