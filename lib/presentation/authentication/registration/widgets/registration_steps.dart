part of '../registration_page.dart';

class RegistrationSteps {
  const RegistrationSteps._();

  static Map<RegistrationStepType, Widget> steps = {
    RegistrationStepType.NAME: const RegistrationNameFormBody(),
    RegistrationStepType.USERNAME: Container(color: Colors.blue),
    RegistrationStepType.EMAIL: Container(color: Colors.green),
    RegistrationStepType.PASSWORD: Container(color: Colors.red),
    RegistrationStepType.GENDER: Container(color: Colors.yellow),
    RegistrationStepType.DATEOFBIRTH: Container(color: Colors.purple),
    RegistrationStepType.AVATAR_URL: Container(color: Colors.orange),
  };
}

class RegistrationNameFormBody extends StatelessWidget with TextFormFieldMixin {
  const RegistrationNameFormBody();

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
                          fontWeight: FontWeight.w600,
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
            EMTextFormField(
              context,
              hintText: 'registration.name_hint_text'.tr(),
              onChanged: (value) {
                context
                    .read<EmailRegistrationBloc>()
                    .addNameUpdated(name: value);
              },
            ),
          ],
        ),
        Positioned(
          bottom: 8,
          right: 0,
          child: BlocBuilder<EmailRegistrationBloc, EmailRegistrationState>(
            builder: (context, state) {
              return RegistrationContinueButton(
                enabled: state.isNameValid,
                onTap: () {
                  context.read<EmailRegistrationBloc>().addNextStep();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
