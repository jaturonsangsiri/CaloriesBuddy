import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cal_track/bloc/theme/theme_bloc.dart';
import 'package:my_cal_track/bloc/user/user_bloc.dart';
import 'package:my_cal_track/contants/contants.dart';
import 'package:my_cal_track/widgets/icons_style.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';
import 'package:my_cal_track/widgets/utils/respone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  File? imagePicker;
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();
  //Api api = Api();

  void pickImage(ImageSource imageType, void Function(void Function()) setState) async {
    imagePicker = await systemwidgetcustom.pickImage(imageType);
    if (imagePicker != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, snapshot) {
        double imageSize = Responsive.isTablet ? 200 : 120;
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Stack(
              children: [
                // รูปโปรไฟล์
                SizedBox(
                  height: Responsive.isTablet ? 350 : 120,
                  width: Responsive.isTablet ? 250 : 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Responsive.isTablet ? 150 : 60),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.pic,
                      placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white70),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ไอคอนกล้อง
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleIcon(
                    icon: const Icon(Icons.camera_alt, color: Colors.white, size: 25),
                    colorbg: Colors.indigoAccent.shade100,
                    padding: 1,
                    function: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // ไม่ให้ปิด Dialog โดยการคลิกนอก Dialog
                        builder: (context) => BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
                          return Center(
                            child: Container(
                              height: Responsive.isTablet ? 430 : 370,
                              width: Responsive.isTablet ? 400 : 300,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(color: themeState.themeApp? Colors.grey.shade100 : const Color.fromRGBO(130, 130, 130, 1), borderRadius: BorderRadius.circular(15)),
                              child: StatefulBuilder(
                                builder: (context, setState) {
                                  return Column(
                                    children: [
                                      imagePicker != null? SizedBox(
                                        height: imageSize,
                                        width: imageSize,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(imageSize / 2),
                                          child: Image.file(
                                            imagePicker!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ) : SizedBox(
                                        height: imageSize,
                                        width: imageSize,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(imageSize / 2),
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.pic,
                                            placeholder: (context, url) => const CircularProgressIndicator(color: Colors.white70),
                                            errorWidget: (context, url, error) => const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      GestureDetector(onTap:() => pickImage(ImageSource.gallery, setState), child: IconText(icon: Icons.photo, text: 'เลือกรูปจากแกลเลอรี', backgroundColor: Colors.grey.shade500, color: Colors.white, size: 25, fontSize: 16)),
                                      const SizedBox(height: 10),
                                      GestureDetector(onTap: () => pickImage(ImageSource.camera, setState), child: IconText(icon: Icons.camera_alt, text: 'ถ่ายรูปใหม่', backgroundColor: Colors.grey.shade500, color: Colors.white, size: 25, fontSize: 16)),
                                      Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          OutlinedButton(
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStateProperty.all<Color>(themeState.themeApp? Colors.grey.shade700 : const Color.fromRGBO(130, 130, 130, 1)),
                                              shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.white, width: 1))),
                                              side: WidgetStateProperty.all<BorderSide>(BorderSide(color: purpleLight),
                                              ),
                                            ),
                                            onPressed: () {
                                              imagePicker = null;
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('ยกเลิก', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w800, color: purpleLight)),
                                          ),
                                          const SizedBox(width: 20),
                                          OutlinedButton(
                                            style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Colors.red.shade400), shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0), side: BorderSide(color: Colors.indigoAccent.shade100, width: 1)))),
                                            onPressed: () async {
                                              // bool result = await api.uploadImage(imagePicker, snapshot.id);
                                              // if(result) {
                                              //   if(context.mounted) {
                                              //     context.read<UsersBloc>().add(SetUser());
                                              //     Navigator.pop(context);
                                              //   }
                                              //   ShowSnackbar.snackbar(ContentType.success, "สำเร็จ", "แก้ไขรูปภาพสำเร็จ");
                                              // } else {
                                              //   ShowSnackbar.snackbar(ContentType.failure, "ผิดพลาด", "ไม่สามารถแก้ไขรูปภาพได้");
                                              // }
                                            },
                                            child: Text('ตกลง', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w800, color: Colors.white)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          );
                        })
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
