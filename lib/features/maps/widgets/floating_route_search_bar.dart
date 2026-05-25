import 'package:flutter/material.dart';

class FloatingRouteSearchBar extends StatelessWidget {
  const FloatingRouteSearchBar({super.key});

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(18),
      color: Colors.transparent,

      child: Container(

        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            // SOURCE
            SizedBox(
              height: 42,

              child: Row(
                children: [

                  const Icon(
                    Icons.radio_button_unchecked,
                    color: Color(0xFF2E7D32),
                    size: 18,
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: TextField(

                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),

                      decoration: InputDecoration(
                        hintText: 'Tenkasi',

                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),

                        border: InputBorder.none,

                        isCollapsed: true,

                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.more_vert,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 28,
              ),

              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
              ),
            ),

            // DESTINATION
            SizedBox(
              height: 42,

              child: Row(
                children: [

                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 18,
                  ),

                  const SizedBox(width: 10),

                  const Expanded(
                    child: TextField(

                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),

                      decoration: InputDecoration(
                        hintText: 'Courtallam',

                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),

                        border: InputBorder.none,

                        isCollapsed: true,

                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: () {},

                    icon: const Icon(
                      Icons.swap_vert,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}