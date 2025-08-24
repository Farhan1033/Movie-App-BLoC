import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_bloc.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_event.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_state.dart';
import 'package:movie_ticket_app/authentication/utils/snackbar_helper.dart';
import 'package:movie_ticket_app/authentication/widgets/auth_header.dart';
import 'package:movie_ticket_app/authentication/widgets/custom_gradient_button.dart';
import 'package:movie_ticket_app/authentication/widgets/custom_password_filed.dart';
import 'package:movie_ticket_app/authentication/widgets/custom_text_filed.dart';
import 'package:movie_ticket_app/authentication/widgets/form_validators.dart';
import 'package:movie_ticket_app/pkg/widget/color.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
          LoginRequest(_emailController.text, _passwordController.text),
        );
  }

  void _navigateToRegister() {
    Navigator.of(context).pushReplacementNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _handleAuthStateChanges,
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          }
          return _buildBody();
        },
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(40),
      child: AppBar(
        backgroundColor: darkBg,
        elevation: 0,
        title: const Text(
          "BioskopKu",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
    );
  }

  void _handleAuthStateChanges(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      SnackBarHelper.showSnackBar(context, 'Successful login');

      Future.delayed(
        const Duration(milliseconds: 2500),
        () {
          if (context.mounted) {
            Navigator.of(context).popAndPushNamed('/home');
          }
        },
      );
    } else if (state is AuthFailure) {
      SnackBarHelper.showSnackBar(context, state.message, isError: true);
    }
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: "Log in",
                subtitle:
                    "Enter your credentials and get back to the cinema world.",
              ),
              const SizedBox(height: 32),
              _buildFormFields(),
              const SizedBox(height: 24),
              CustomGradientButton(
                text: "Sign Up",
                onPressed: _login,
              ),
              const SizedBox(height: 16),
              _buildLoginPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        const SizedBox(height: 16),
        CustomTextField(
          label: "Email",
          controller: _emailController,
          hintText: "Enter your email address",
          validator: FormValidators.validateEmail,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        CustomPasswordField(
          label: "Password",
          controller: _passwordController,
          hintText: "Enter your password",
          isVisible: _isPasswordVisible,
          onVisibilityToggle: () =>
              setState(() => _isPasswordVisible = !_isPasswordVisible),
          validator: FormValidators.validatePassword,
        ),
      ],
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
        TextButton(
          onPressed: _navigateToRegister,
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: Color(0xFF871308),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
