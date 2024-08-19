import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../components/loading.dart';
import '../../../controller/editProfile_controller.dart';
import '../../../helpers/image_picker.dart';

class EditProfile extends GetView<EditprofileController> {
  static const routeName = '/editProfile';
  const EditProfile({super.key, this.editPasswordOnly = false,});

  final bool editPasswordOnly;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.chevron_left,
            color: primaryColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryColor,
        onPressed: () => controller.saveDetails(),
        label: Text(
          editPasswordOnly ? 'Change Password' : 'Save Details',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        icon: Icon(
          editPasswordOnly ? Icons.key : Icons.save,
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Loading(
              color: primaryColor,
              kSize: 40,
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                editPasswordOnly
                    ? const SizedBox.shrink()
                    : ProfileImagePicker(
                  selectImage: (image) => controller.profileImage = image,
                  isReg: false,
                  imgUrl: controller.emailController.text,
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    editPasswordOnly || controller.changePassword.value
                        ? 'Change Password'
                        : 'Edit Profile Details',
                    style: const TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      editPasswordOnly
                          ? const SizedBox.shrink()
                          : Column(
                        children: [
                          _buildTextField(
                            controller.emailController,
                            'Email Address',
                            Field.email,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            controller.fullnameController,
                            'Fullname',
                            Field.fullname,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            controller.phoneController,
                            'Phone Number',
                            Field.phone,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            controller.addressController,
                            'Delivery Address',
                            Field.address,
                          ),
                        ],
                      ),
                      editPasswordOnly
                          ? const SizedBox.shrink()
                          : Row(
                        children: [
                          Text(
                            controller.changePassword.value
                                ? 'Don\'t change password'
                                : 'Change Password',
                            style: const TextStyle(color: primaryColor),
                          ),
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: primaryColor,
                            value: controller.changePassword.value,
                            onChanged: (value) => controller.changePassword.value = value!,
                            side: const BorderSide(
                              color: primaryColor,
                              width: 1,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                      controller.changePassword.value || editPasswordOnly
                          ? _buildTextField(
                        controller.passwordController,
                        'Password',
                        Field.password,
                        obscureText: controller.obscure.value,
                        onToggleObscure: controller.togglePasswordObscure,
                      )
                          : const SizedBox.shrink(),
                      const SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      Field field, {
        bool obscureText = false,
        VoidCallback? onToggleObscure,
      }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: field == Field.email
          ? TextInputType.emailAddress
          : field == Field.phone
          ? TextInputType.phone
          : TextInputType.text,
      textInputAction:
      field == Field.password ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: primaryColor),
        suffixIcon: field == Field.password
            ? controller.text.isNotEmpty
            ? IconButton(
          onPressed: onToggleObscure,
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: primaryColor,
          ),
        )
            : const SizedBox.shrink()
            : const SizedBox.shrink(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 2,
            color: primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 1,
            color: Colors.grey,
          ),
        ),
      ),
      validator: (value) {
        switch (field) {
          case Field.email:
            if (!value!.contains('@')) {
              return 'Email is not valid!';
            }
            if (value.isEmpty) {
              return 'Email cannot be empty';
            }
            break;
          case Field.fullname:
            if (value!.isEmpty || value.length < 3) {
              return 'Fullname is not valid';
            }
            break;
          case Field.phone:
            if (value!.isEmpty || value.length < 10) {
              return 'Phone number is not valid';
            }
            break;
          case Field.address:
            if (value!.isEmpty || value.length < 10) {
              return 'Delivery address is not valid';
            }
            break;
          case Field.password:
            if (value!.isEmpty || value.length < 8) {
              return 'Password needs to be valid';
            }
            break;
        }
        return null;
      },
    );
  }
}









// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controller/ProfileController.dart';
// import '../../../components/loading.dart';
// import '../../../constants/colors.dart';
// import '../../../controller/editProfile_controller.dart';
// import '../../../helpers/image_picker.dart';
//
// class EditProfile extends GetView<EditprofileController> {
//   static const routeName = '/editProfile';
//   const EditProfile({Key? key, this.editPasswordOnly = false}) : super(key: key);
//   final bool editPasswordOnly;
//
//   @override
//   Widget build(BuildContext context) {
//
//     Widget kTextField(
//         TextEditingController controller,
//         String hint,
//         String label,
//         Field field,
//         bool obscureText,
//         ) {
//       return Obx(() => TextFormField(
//         controller: controller,
//         obscureText: obscureText,
//         keyboardType: field == Field.email
//             ? TextInputType.emailAddress
//             : field == Field.phone
//             ? TextInputType.phone
//             : TextInputType.text,
//         textInputAction: field == Field.password
//             ? TextInputAction.done
//             : TextInputAction.next,
//         autofocus: field == Field.email ? true : false,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: const TextStyle(color: primaryColor),
//           suffixIcon: field == Field.password
//               ? controller.text.isNotEmpty
//               ? IconButton(
//             onPressed: controller == Get.find<EditprofileController>().passwordController ? Get.find<EditprofileController>().togglePasswordObscure : null,
//             icon: Icon(
//               controller == Get.find<EditprofileController>().passwordController && Get.find<EditprofileController>().obscure.value ? Icons.visibility : Icons.visibility_off,
//               color: primaryColor,
//             ),
//           )
//               : const SizedBox.shrink()
//               : const SizedBox.shrink(),
//           hintText: hint,
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: const BorderSide(
//               width: 2,
//               color: primaryColor,
//             ),
//           ),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//             borderSide: const BorderSide(
//               width: 1,
//               color: Colors.grey,
//             ),
//           ),
//         ),
//         validator: (value) {
//           switch (field) {
//             case Field.email:
//               if (!value!.contains('@')) {
//                 return 'Email is not valid!';
//               }
//               if (value.isEmpty) {
//                 return 'Email can not be empty';
//               }
//               break;
//             case Field.fullname:
//               if (value!.isEmpty || value.length < 3) {
//                 return 'Fullname is not valid';
//               }
//               break;
//             case Field.phone:
//               if (value!.isEmpty || value.length < 10) {
//                 return 'Phone number is not valid';
//               }
//               break;
//             case Field.address:
//               if (value!.isEmpty || value.length < 10) {
//                 return 'Delivery address is not valid';
//               }
//               break;
//             case Field.password:
//               if (value!.isEmpty || value.length < 8) {
//                 return 'Password needs to be valid';
//               }
//               break;
//           }
//           return null;
//         },
//       )
//
//       );
//     }
//
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: Builder(builder: (context) {
//           return GestureDetector(
//             onTap: () => Navigator.of(context).pop(),
//             child: const Icon(
//               Icons.chevron_left,
//               color: primaryColor,
//             ),
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: primaryColor,
//         onPressed: Get.find<EditprofileController>().saveDetails,
//         label: Text(
//           editPasswordOnly ? 'Change Password' : 'Save Details',
//           style: const TextStyle(color: Colors.white),
//         ),
//         icon: Icon(
//           editPasswordOnly ? Icons.key : Icons.save,
//           color: Colors.white,
//         ),
//       ),
//       body: Obx(() => Get.find<EditprofileController>().isLoading.value
//           ? const Center(
//         child: Loading(
//           color: primaryColor,
//           kSize: 40,
//         ),
//       )
//           : Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             editPasswordOnly
//                 ? const SizedBox.shrink()
//                 : ProfileImagePicker(
//               selectImage: (image) {
//                 Get.find<EditprofileController>().profileImage = image;
//               },
//               isReg: false,
//               imgUrl: Get.find<EditprofileController>().emailController.text,
//             ),
//             const SizedBox(height: 10),
//             Center(
//               child: Text(
//                 editPasswordOnly || Get.find<EditprofileController>().changePassword.value
//                     ? 'Change Password'
//                     : 'Edit Profile Details',
//                 style: const TextStyle(
//                   color: primaryColor,
//                   fontSize: 18,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Form(
//               key: Get.find<EditprofileController>().formKey, // Use formKey from controller
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   editPasswordOnly
//                       ? const SizedBox.shrink()
//                       : Column(
//                     children: [
//                       kTextField(
//                         Get.find<EditprofileController>().emailController,
//                         Get.find<EditprofileController>().emailController.text,
//                         'Email Address',
//                         Field.email,
//                         false,
//                       ),
//                       const SizedBox(height: 15),
//                       kTextField(
//                         Get.find<EditprofileController>().fullnameController,
//                         Get.find<EditprofileController>().fullnameController.text,
//                         'Full Name',
//                         Field.fullname,
//                         false,
//                       ),
//                       const SizedBox(height: 15),
//                       kTextField(
//                         Get.find<EditprofileController>().phoneController,
//                         Get.find<EditprofileController>().phoneController.text,
//                         'Phone Number',
//                         Field.phone,
//                         false,
//                       ),
//                       const SizedBox(height: 15),
//                       kTextField(
//                         Get.find<EditprofileController>().addressController,
//                         Get.find<EditprofileController>().addressController.text,
//                         'Address',
//                         Field.address,
//                         false,
//                       ),
//                       const SizedBox(height: 30),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       Text(
//                         Get.find<EditprofileController>().changePassword.value
//                             ? 'Don\'t change password'
//                             : 'Change Password',
//                         style: const TextStyle(color: primaryColor),
//                       ),
//                       Checkbox(
//                         checkColor: Colors.white,
//                         activeColor: primaryColor,
//                         value: Get.find<EditprofileController>().changePassword.value,
//                         onChanged: (value) {
//                           Get.find<EditprofileController>().changePassword.value = value!;
//                         },
//                         side: const BorderSide(
//                           color: primaryColor,
//                           width: 1,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Get.find<EditprofileController>().changePassword.value || editPasswordOnly
//                       ? kTextField(
//                     Get.find<EditprofileController>().passwordController,
//                     '********',
//                     'Password',
//                     Field.password,
//                     Get.find<EditprofileController>().obscure.value,
//                   )
//                       : const SizedBox.shrink(),
//                   const SizedBox(height: 30),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }