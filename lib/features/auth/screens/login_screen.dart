import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_clone/common/utils/utils.dart';
import 'package:whatsapp_clone/common/widgets/custom_button.dart';
import 'package:whatsapp_clone/common/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whatsapp_clone/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const routeName = '/login-screen';
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  var isLoading = false;
  final phoneController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  Country? country;

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar(
        context: context,
        content: 'Country NOT selected!',
        bgColor: tabColor,
        textColor: blackThemeColor,
      );
      return;
    }
    if (country != null && phoneNumber.isNotEmpty && phoneNumber.length == 10) {
      setState(() {
        isLoading = true;
      });
      ref.read(authControllerProvider).signInWithPhone(
            context,
            '+${country!.phoneCode}$phoneNumber',
          );
      // Provider ref -> Interact provider with provider
      // Widget ref -> Intract widget with provider
    }

    if (phoneNumber.length != 10 || int.tryParse(phoneNumber) == null) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showSnackBar(
        context: context,
        content: 'Invalid phone number!',
        bgColor: tabColor,
        textColor: blackThemeColor,
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text('Enter your phone number'),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              height: screenSize.height * 0.85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'WhatsApp will need to verify your phone number.',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode:
                            true, // optional. Shows phone code before the country name.
                        onSelect: (Country ctry) {
                          setState(() {
                            country = ctry;
                          });
                        },
                      );
                    },
                    child: const Text(
                      'pick country',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        country == null
                            ? ''
                            : '+${country!.phoneCode.toString()}',
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                        width: screenSize.width * 0.75,
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'phone number',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 90,
                    child: CustomButton(
                      text: 'NEXT',
                      loading: isLoading,
                      onPressedFunction: sendPhoneNumber,
                    ),
                  ),
                  SizedBox(height: screenSize.height / 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
