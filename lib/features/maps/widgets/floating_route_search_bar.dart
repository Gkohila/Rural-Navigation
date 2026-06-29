import 'package:flutter/material.dart';

class FloatingRouteSearchBar extends StatelessWidget {

  final String source;
  final String destination;

  const FloatingRouteSearchBar({
    super.key,
    required this.source,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {

    return Stack(

      clipBehavior: Clip.none,

      children: [

        /// ================= MAIN SEARCH BOX =================
        Container(

          /// 🔥 MORE GAP FOR FLOATING BACK BUTTON
          margin: const EdgeInsets.only(
            left: 58,
          ),

          padding: const EdgeInsets.only(
            left: 16,
            right: 12,
            top: 10,
            bottom: 10,
          ),

          decoration: BoxDecoration(

            color:
      Colors.white.withOpacity(0.88),

            borderRadius:
                BorderRadius.circular(22),

            boxShadow: [

              BoxShadow(

                color:
                    Colors.black.withOpacity(
                  0.06,
                ),

                blurRadius: 18,

                offset:
                    const Offset(0, 6),
              ),
            ],
          ),

          child: Row(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              /// ================= LEFT SIDE ICONS =================
              Column(

                children: [

                  const SizedBox(height: 8),

                  Icon(

                    Icons.radio_button_checked,

                    color:
                        const Color(0xFF0B5D1E),

                    size: 15,
                  ),

                  Column(

                    children: List.generate(
                      5,

                      (_) => Container(

                        margin:
                            const EdgeInsets.symmetric(
                          vertical: 1.5,
                        ),

                        width: 2,
                        height: 4,

                        decoration:
                            BoxDecoration(

                          color:
                              Colors.grey.shade400,

                          borderRadius:
                              BorderRadius.circular(
                            10,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Icon(

                    Icons.location_on,

                    color:
                        Colors.red.shade500,

                    size: 21,
                  ),
                ],
              ),

              const SizedBox(width: 10),

              /// ================= TEXT FIELDS =================
              Expanded(

                child: Column(

                  children: [

                    /// SOURCE
                    Container(

                      height: 44,

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        border:
                            Border.all(
                          color:
                              Colors.grey.shade300,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child: Align(
  alignment: Alignment.centerLeft,
  child: TextField(
    controller: TextEditingController(
      text: source,
    ),
    decoration: const InputDecoration(
      hintText: 'Your location',

                            hintStyle:
                                TextStyle(

                              fontSize: 16,

                              fontWeight:
                                  FontWeight.w500,

                              color:
                                  Color(0xFF0B5D1E),
                            ),

                            border:
                                InputBorder.none,

                            isCollapsed:
                                true,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// DESTINATION
                    Container(

                      height: 44,

                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 14,
                      ),

                      decoration: BoxDecoration(

                        color: Colors.white,

                        border:
                            Border.all(
                          color:
                              Colors.grey.shade300,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child: Align(
  alignment: Alignment.centerLeft,
  child: TextField(
    controller: TextEditingController(
      text: destination,
    ),
    decoration: const InputDecoration(
      hintText: 'Choose destination',

                            hintStyle:
                                TextStyle(

                              fontSize: 16,

                              fontWeight:
                                  FontWeight.w500,

                              color:
                                  Colors.black54,
                            ),

                            border:
                                InputBorder.none,

                            isCollapsed:
                                true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// ================= RIGHT SIDE ICONS =================
              Column(

                children: [

                  const SizedBox(height: 4),

                  /// SWAP ICON
                  Container(

                    width: 40,
                    height: 40,

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.grey.shade100,

                      shape:
                          BoxShape.circle,
                    ),

                    child: const Icon(

                      Icons.swap_vert_rounded,

                      size: 22,

                      color:
                          Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// MIC ICON
                  Container(

                    width: 40,
                    height: 40,

                    decoration:
                        BoxDecoration(

                      color:
                          Colors.grey.shade100,

                      shape:
                          BoxShape.circle,
                    ),

                    child: const Icon(

                      Icons.mic_none_rounded,

                      size: 22,

                      color:
                          Colors.black87,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// ================= FLOATING BACK BUTTON =================
        Positioned(

          left: 0,
          top: 34,

          child: GestureDetector(

            onTap: () {

              Navigator.of(context)
                  .maybePop();
            },

            child: Container(

              width: 42,
              height: 42,

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                  14,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                        Colors.black.withOpacity(
                      0.06,
                    ),

                    blurRadius: 10,

                    offset:
                        const Offset(0, 4),
                  ),
                ],
              ),

              child: const Icon(

                Icons.arrow_back,

                size: 24,

                color: Colors.black87,
              ),
            ),
          ),
        ),
      ],
    );
  }
}