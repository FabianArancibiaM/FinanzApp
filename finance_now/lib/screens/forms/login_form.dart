import 'package:finance_now/bloc/forms/login/login_cubit.dart';
import 'package:finance_now/bloc/forms/movement/movement_cubit.dart';
import 'package:finance_now/providers/user_provider.dart';
import 'package:finance_now/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginForms extends StatefulWidget {
  const LoginForms({Key? key}) : super(key: key);

  @override
  State<LoginForms> createState() => _LoginFormsState();
}

class _LoginFormsState extends State<LoginForms> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Container(
          padding: EdgeInsets.only(bottom: 50, left: 10, right: 10),
          child: const _FormContain()),
    );
  }
}

class _FormContain extends StatelessWidget {
  const _FormContain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final colors = Theme.of(context).colorScheme.primary;

    final loginCubi = context.watch<LoginCubit>();
    final description = loginCubi.state.email;

    return Stack(
      children: [
        Visibility(
          visible: loginCubi.state.formStatus == FormStatus.validating,
          child: Center(
              child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: CircularProgressIndicator(
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation<Color>(colors),
            ),
          )),
        ),
        Form(
          child: Column(
            children: [
              CustomTextFormField(
                label: 'Ingrese Correo',
                onChange: loginCubi.emailChange,
                errorMessage: description.errorMessages,
                stateForm: loginCubi.state.formStatus,
              ),
              SizedBox(
                height: 10,
              ),
              FilledButton.tonalIcon(
                  style: ButtonStyle(
                    textStyle: MaterialStateProperty.all<TextStyle>(
                      TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
                  ),
                  onPressed: () async {
                    loginCubi.onSubmit(userProvider).then((value) {
                      if (value) {
                        Navigator.pushNamed(context, 'menu');
                      }
                    });
                  },
                  icon: const Icon(Icons.login),
                  label: const Text('Ingresar')),
            ],
          ),
        )
      ],
    );
  }
}
