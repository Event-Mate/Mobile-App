import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/interests_edit_bloc/interests_edit_bloc.dart';
import 'package:event_mate/presentation/core/constants/app_text_styles.dart';
import 'package:event_mate/presentation/core/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/core/extension/build_context_toast_msg_ext.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/custom_placeholder.dart';
import 'package:event_mate/presentation/core/widgets/custom_progress_indicator.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationInterestsFormBody extends StatefulWidget {
  const RegistrationInterestsFormBody();

  @override
  State<RegistrationInterestsFormBody> createState() =>
      _RegistrationInterestsFormBodyState();
}

class _RegistrationInterestsFormBodyState
    extends State<RegistrationInterestsFormBody> {
  @override
  void initState() {
    super.initState();
    context.read<InterestsEditBloc>().addFetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InterestsEditBloc, InterestsEditState>(
      listenWhen: (previous, current) {
        return previous.validating && !current.validating;
      },
      listener: (context, state) {
        if (!state.isFormValid) {
          return context
              .showErrorToast('registration.interests_size_error_message'.tr());
        }

        final bloc = context.read<EmailRegistrationBloc>();
        final registrationData = bloc.state.registrationData;
        bloc.addNextStep(
          registrationData: registrationData.copyWith(
            interests: state.selectedInterests,
          ),
        );
      },
      child: BlocBuilder<InterestsEditBloc, InterestsEditState>(
        builder: (context, state) {
          final interestCategories = state.eventCategoriesOrEmptyList;
          return FormBody(
            title: 'registration.interests_form_title'.tr(),
            subtitle: 'registration.interests_form_subtitle'.tr(),
            formField: Container(
              height: 400,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: context.colors.background,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: state.selectedInterests.size > 2
                        ? context.colors.primary
                        : context.colors.accent.withOpacity(.15),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: state.failureOrInterestListOption.isNone()
                  ? const Center(child: CustomProgressIndicator())
                  : GridView.builder(
                      shrinkWrap: true,
                      itemCount: interestCategories.size,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        final interest = interestCategories[index];
                        return BouncingButton(
                          onTap: () {
                            context
                                .read<InterestsEditBloc>()
                                .addInterestToggled(interest: interest);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                    state.selectedInterests.contains(interest)
                                        ? context.colors.primary
                                        : context.colors.surfacePrimary,
                                width: 4,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: interest.imageUrl,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return const CustomPlaceholder();
                                    },
                                    errorWidget: (context, url, error) {
                                      return const CustomPlaceholder();
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        context.colors.blackBase.withOpacity(0),
                                        context.colors.blackBase.withOpacity(1),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                Align(
                                  child: AutoSizeText(
                                    interest.title,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    minFontSize: 8,
                                    overflow: TextOverflow.ellipsis,
                                    style: tsBodySmall.copyWith(
                                      color: context.colors.whiteBase,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            onRegistrationContinue: () {
              context.read<InterestsEditBloc>().addInterestsValidate();
            },
          );
        },
      ),
    );
  }
}
