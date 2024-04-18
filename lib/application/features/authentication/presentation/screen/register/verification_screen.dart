import 'package:bmw_world/application/features/authentication/presentation/screen/register/success_screen.dart';
import 'package:bmw_world/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../generated/l10n.dart';
import '../../../../../core/helper/error_handler.dart';
import 'bloc/register_bloc.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return BlocSelector<RegisterBloc, RegisterState, bool>(
          selector: (state) => state.isVerificationSuccess ?? false,
          builder: (context, isVerificationSuccess) {
            if (isVerificationSuccess) {
              _scaffoldKey.currentState?.showBottomSheet(
                enableDrag: true,
                (context) {
                  return const SuccessScreen();
                },
              );
            }
            return const VerificationScreenContent();
          },
        );
      },
    );
  }
}

class VerificationScreenContent extends StatefulWidget {
  const VerificationScreenContent({Key? key}) : super(key: key);

  @override
  State<VerificationScreenContent> createState() => _VerificationScreenContentState();
}

class _VerificationScreenContentState extends State<VerificationScreenContent> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  final otpSize = 4;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(otpSize, (_) => TextEditingController());
    _focusNodes = List.generate(otpSize, (_) => FocusNode());
    for (int i = 0; i < otpSize - 1; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < otpSize - 1) {
          FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
        }
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void onPressedVerify(BuildContext context) {
    final bloc = context.read<RegisterBloc>();
    String verifyCode = _controllers.fold<String>(
        '', (previousValue, controller) => previousValue + controller.text);
    bloc.add(RegisterEvent.verify(verifyCode));
  }

  bool _isVerifyEnabled() {
    for (var controller in _controllers) {
      if (controller.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.verificationError != null) {
          final errorMessage = getExceptionMessage(
            exception: state.verificationError,
            badRequestMessage: "Wrong verification code",
          );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   errorSnackBarWidget(context, errorMessage),
          // );
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.icBmwActive),
                const SizedBox(height: 10),
                Text(S.of(context).checkYourEmail,
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 5),
                Text(S.of(context).weSentVerificationCode,
                    style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 3),
                Text("email", style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 10),

                /// Text field OTP
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    4,
                    (index) => _textFieldOTP(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      nextFocus: index < 3 ? _focusNodes[index + 1] : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Verify Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isVerifyEnabled() ? () => onPressedVerify(context) : null,
                    child: Text(S.of(context).verify),
                  ),
                ),

                /// ClickToResend Button
                const ClickToResend(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocus,
  }) {
    return SizedBox(
      width: 64,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: (value) {
          setState(() {});
          if (value.isNotEmpty && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counter: Offstage(),
        ),
      ),
    );
  }
}

class ClickToResend extends StatelessWidget {
  const ClickToResend({super.key});

  void onPressedClickToResend(BuildContext context) {
    context.read<RegisterBloc>().add(RegisterEvent.sendVerificationCode());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).didntReceiveEmail),
            TextButton(
              onPressed: () => onPressedClickToResend(context),
              child: Text(S.of(context).clickToResend),
            ),
          ],
        );
      },
    );
  }
}
