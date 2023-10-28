import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/presentation/authentication/registration/widgets/registration_continue_button.dart';
import 'package:event_mate/presentation/authentication/registration/widgets/registration_progress_circle.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_back_button.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final PageController pageController;
  late int _currentPageIndex;
  late int _totalPageCount;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _currentPageIndex = 0;
    // TODO(Furkan): Change this value according to your list size
    _totalPageCount = 7;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (Navigator.of(context).userGestureInProgress)
          return Future.value(false);
        else
          return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: AppBar(
          backgroundColor: context.colors.background,
          elevation: 0,
          leading: BouncingBackButton(
            onTap: () {
              if (_currentPageIndex == 0) {
                Navigator.of(context).pop();
              } else {
                _navigateToPreviousStep();
              }
            },
          ),
          centerTitle: true,
          title: Row(
            children: [
              for (int i = 0; i < _totalPageCount; i++) ...[
                const RegistrationProgressCircle(),
                if (i != _totalPageCount - 1)
                  Container(
                    width: 20,
                    height: 1,
                    color: context.colors.textPrimary,
                  )
              ],
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [
                      const _NameFormView(),
                      Container(
                        color: Colors.blue,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _navigateToPreviousStep();
                            },
                            child: const Text('Back'),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextStep() {
    pageController.animateToPage(
      _currentPageIndex + 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _currentPageIndex++;
  }

  void _navigateToPreviousStep() {
    pageController.animateToPage(
      _currentPageIndex - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _currentPageIndex--;
  }
}

class _NameFormView extends StatelessWidget {
  const _NameFormView();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'registration.welcoming_text',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: context.colors.textPrimary,
                        ),
                  ).tr(),
                  const SizedBox(height: 2),
                  Text(
                    'registration.name_form_title',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: context.colors.textPrimary),
                  ).tr(),
                ],
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: context.colors.surfacePrimary,
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: context.colors.borderPrimary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: context.colors.textPrimary),
                ),
                hintText: 'registration.name_hint_text'.tr(),
                hintStyle: TextStyle(color: context.colors.textSecondary),
              ),
            ),
          ],
        ),
        const Positioned(
          right: 0,
          bottom: 8,
          child: RegistrationContinueButton(),
        )
      ],
    );
  }
}
