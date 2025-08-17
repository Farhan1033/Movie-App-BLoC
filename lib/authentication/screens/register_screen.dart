import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_bloc.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_event.dart';
import 'package:movie_ticket_app/authentication/bloc/auth_state.dart';
import 'package:movie_ticket_app/authentication/widgets/form_validators.dart';
import 'package:movie_ticket_app/authentication/widgets/custom_text_filed.dart';
import 'package:movie_ticket_app/authentication/widgets/custom_password_filed.dart';
import 'package:movie_ticket_app/authentication/widgets/custom_gradient_button.dart';
import 'package:movie_ticket_app/authentication/widgets/auth_header.dart';
import 'package:movie_ticket_app/authentication/utils/snackbar_helper.dart';
import 'package:movie_ticket_app/pkg/widget/color.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      SnackBarHelper.showSnackBar(
        context,
        'The passwords do not match. Please check your password again.',
        isError: true,
      );
      return;
    }

    context.read<AuthBloc>().add(RegisterRequest(
          _emailController.text.trim(),
          _passwordController.text,
          _fullNameController.text.trim(),
          _phoneNumberController.text.trim(),
        ));
  }

  void _navigateToLogin() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBg,
      appBar: _buildAppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        listener: _handleAuthStateChanges,
        child: BlocBuilder<AuthBloc, AuthState>(
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
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
      SnackBarHelper.showSnackBar(context, 'Successfully created an account');

      Future.delayed(const Duration(milliseconds: 1000), () {
        if (context.mounted) {
          Navigator.of(context).pushReplacementNamed('/login');
        }
      });
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
                title: "Create Account",
                subtitle:
                    "One step away from joining the ultimate cinema experience",
              ),
              const SizedBox(height: 32),
              _buildFormFields(),
              const SizedBox(height: 24),
              CustomGradientButton(
                text: "Sign Up",
                onPressed: _register,
              ),
              const SizedBox(height: 16),
              _buildRegisterPrompt(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        CustomTextField(
          label: "Full Name",
          controller: _fullNameController,
          hintText: "Enter your full name",
          validator: FormValidators.validateFullName,
          textInputAction: TextInputAction.next,
        ),
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
        CustomTextField(
          label: "Phone Number",
          controller: _phoneNumberController,
          hintText: "Enter your phone number",
          validator: FormValidators.validatePhoneNumber,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
        const SizedBox(height: 16),
        CustomPasswordField(
          label: "Confirm Password",
          controller: _confirmPasswordController,
          hintText: "Re-enter your password",
          isVisible: _isConfirmPasswordVisible,
          onVisibilityToggle: () => setState(
              () => _isConfirmPasswordVisible = !_isConfirmPasswordVisible),
          validator: (value) => FormValidators.validateConfirmPassword(value),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildRegisterPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
        TextButton(
          onPressed: _navigateToLogin,
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
