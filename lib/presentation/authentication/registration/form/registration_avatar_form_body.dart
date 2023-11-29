import 'package:easy_localization/easy_localization.dart';
import 'package:event_mate/application/avatar_edit_bloc/avatar_edit_bloc.dart';
import 'package:event_mate/application/email_registration_bloc/email_registration_bloc.dart';
import 'package:event_mate/application/image_picker_bloc/image_picker_bloc.dart';
import 'package:event_mate/injection.dart';
import 'package:event_mate/presentation/core/widgets/bouncing_button.dart';
import 'package:event_mate/presentation/core/widgets/form_body.dart';
import 'package:event_mate/presentation/extension/build_context_theme_ext.dart';
import 'package:event_mate/presentation/extension/build_context_toast_msg_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationAvatarFormBody extends StatelessWidget {
  const RegistrationAvatarFormBody();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ImagePickerBloc>(),
      child: BlocListener<ImagePickerBloc, ImagePickerState>(
        listenWhen: (previous, current) =>
            previous.failureOrImageOption != current.failureOrImageOption,
        listener: (context, state) {
          state.failureOrImageOption.fold(
            () {},
            (failureOrImgFile) {
              failureOrImgFile.fold(
                (failure) {
                  context.showErrorToast(
                    'registration.avatar_form_error_message'.tr(),
                  );
                },
                (imgFile) {
                  if (imgFile != null) {
                    context
                        .read<AvatarEditBloc>()
                        .addAvatarUpdated(avatarFile: imgFile);
                  }
                },
              );
            },
          );
        },
        child: FormBody(
          title: 'registration.avatar_form_title'.tr(),
          subtitle: 'registration.avatar_form_subtitle'.tr(),
          formField: const Center(
            child: _AvatarForm(),
          ),
          skipStepButton: const _SkipStepButton(),
          onSubmit: () {
            final bloc = context.read<EmailRegistrationBloc>();
            final userData = bloc.state.userData;
            bloc.addCompleteRegistration(
              user: userData.copyWith(
                avatarFile: context.read<AvatarEditBloc>().state.avatarOrNull,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SkipStepButton extends StatelessWidget {
  const _SkipStepButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) {
        final isUploaded = state.imageFile != null;

        if (isUploaded) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(top: 12),
          child: BouncingButton(
            onTap: () {
              final bloc = context.read<EmailRegistrationBloc>();
              bloc.addCompleteRegistration(user: bloc.state.userData);
            },
            child: Text(
              'registration.avatar_form_skip_for_now'.tr(),
              style: TextStyle(
                color: context.colors.textSecondary,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AvatarForm extends StatelessWidget {
  const _AvatarForm();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerBloc, ImagePickerState>(
      builder: (context, state) {
        final isUploaded = state.imageFile != null;
        final uploading = state.uploading;
        final extent = MediaQuery.of(context).size.width * 0.7;
        return Container(
          margin: const EdgeInsets.only(top: 16, bottom: 64),
          height: extent,
          width: extent,
          decoration: BoxDecoration(
            color: context.colors.surfacePrimary,
            borderRadius: const BorderRadius.all(Radius.circular(200)),
            border: Border.all(
              color: isUploaded
                  ? context.colors.primary
                  : context.colors.borderPrimary,
              width: 4,
            ),
          ),
          child: uploading
              ? Center(
                  child: CircularProgressIndicator(
                    color: context.colors.primary,
                  ),
                )
              : isUploaded
                  ? ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(200)),
                      child: Image.file(
                        state.imageFile!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const _UploadAvatarButton(),
        );
      },
    );
  }
}

class _UploadAvatarButton extends StatelessWidget {
  const _UploadAvatarButton();

  @override
  Widget build(BuildContext context) {
    return BouncingButton(
      onTap: () {
        context.read<ImagePickerBloc>().addPickImageFromGallery();
      },
      child: Icon(
        Icons.person_add_alt_1_rounded,
        size: 150,
        color: context.colors.textSecondary,
      ),
    );
  }
}
