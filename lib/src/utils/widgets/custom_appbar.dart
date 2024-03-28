import 'package:cached_network_image/cached_network_image.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String buttonName;
  final void Function()? onPressed;

  const CustomAppBar(
      {super.key, this.title = '', this.onPressed, this.buttonName = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          width: context.width,
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(50),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  color: context.theme.scaffoldBackgroundColor,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.notifications_outlined,
                        color: AppColors.primary),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // CacheImage(
              //   height: 54,
              //   width: 54,
              //   fit: BoxFit.cover,
              //   url: app.user.startup.logoFile,
              // ),
              CircleAvatar(
                  radius: 27,
                  foregroundImage: CachedNetworkImageProvider(
                    app.user.startup.logoFile,
                  )),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () async {
                  Get.defaultDialog(
                    title: "Logout",
                    middleText: "Are you sure you want to logout?",
                    textConfirm: "Yes",
                    textCancel: "No",
                    onCancel: Get.back,
                    onConfirm: () async {},
                  );
                },
                icon: const Icon(Icons.logout),
              ),
              // const CircleAvatar(
              //     radius: 27,
              //     foregroundImage: CachedNetworkImageProvider(
              //       ,
              //     )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 26,
                  color: AppColors.primary,
                ),
              ),
              CustomElevatedButton(
                isLoginGradient: false,
                width: 215,
                height: 50,
                onPressed: onPressed,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: context.theme.scaffoldBackgroundColor,
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        buttonName,
                        style: TextStyle(
                          color: context.theme.scaffoldBackgroundColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
