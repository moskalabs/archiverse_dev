import '/core/responsive_wrapper.dart';
        body: ResponsiveWrapper(
          child: SafeArea(
            top: true,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (responsiveVisibility(
                  context: context,
                  phone: false,
                ))
                  Container(
              ],
            ),
