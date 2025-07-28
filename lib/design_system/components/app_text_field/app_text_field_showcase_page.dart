import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../showcase_card.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import 'app_text_field.dart';
import 'app_text_field_wrapper.dart';

@RoutePage()
class AppTextFieldShowcasePage extends StatefulWidget {
  const AppTextFieldShowcasePage({super.key});

  @override
  State<AppTextFieldShowcasePage> createState() =>
      _AppTextFieldShowcasePageState();
}

class _AppTextFieldShowcasePageState extends State<AppTextFieldShowcasePage> {
  final TextEditingController _basicController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _multilineController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _errorController = TextEditingController();

  @override
  void dispose() {
    _basicController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _searchController.dispose();
    _multilineController.dispose();
    _phoneController.dispose();
    _numberController.dispose();
    _errorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppTextField'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.lg.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Default text field components with clean, minimal styling',
              style: AppTextStyle.bodyLarge.style.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),

            AppSpacing.xl.gapV,

            // Basic Components Section
            _buildSection(
              title: 'Basic Components',
              description: 'Simple text field and wrapper with external labels',
              children: [
                ShowcaseCard(
                  title: 'AppTextField',
                  description: 'Basic text field component',
                  child: AppTextField(
                    controller: _basicController,
                  ),
                ),
                ShowcaseCard(
                  title: 'AppTextFieldWrapper',
                  description: 'Text field with external title and description',
                  child: AppTextFieldWrapper(
                    title: 'Full Name',
                    description: 'Enter your full legal name',
                    isMandatory: true,
                    child: AppTextField(),
                  ),
                ),
              ],
            ),

            // Factory Types Section  
            _buildSection(
              title: 'Specialized Types',
              description: 'Pre-configured inputs for common use cases',
              children: [
                ShowcaseCard(
                  title: 'Email',
                  description: 'Email input with appropriate keyboard',
                  child: AppTextField.email(
                    controller: _emailController,
                  ),
                ),
                ShowcaseCard(
                  title: 'Password',
                  description: 'Password input with visibility toggle',
                  child: AppTextField.password(
                    controller: _passwordController,
                  ),
                ),
                ShowcaseCard(
                  title: 'Search',
                  description: 'Search input with filled background',
                  child: AppTextField.search(
                    controller: _searchController,
                  ),
                ),
                ShowcaseCard(
                  title: 'Phone',
                  description: 'Phone number input',
                  child: AppTextField.phone(
                    controller: _phoneController,
                  ),
                ),
                ShowcaseCard(
                  title: 'Number',
                  description: 'Numeric input',
                  child: AppTextField.number(),
                ),
                ShowcaseCard(
                  title: 'Multiline',
                  description: 'Text area for longer input',
                  child: AppTextField.multiline(
                    controller: _multilineController,
                    maxLines: 3,
                  ),
                ),
                ShowcaseCard(
                  title: 'With Hint Text',
                  description: 'Field with placeholder hint text',
                  child: AppTextField(
                    hintText: 'Enter your text here...',
                  ),
                ),
                ShowcaseCard(
                  title: 'Clear Button',
                  description: 'Field with clear functionality',
                  child: AppTextField(
                    allowClear: true,
                    initialValue: 'Sample text - try clearing it',
                  ),
                ),
                ShowcaseCard(
                  title: 'Suffix Icon Button',
                  description: 'Field with custom suffix action button',
                  child: AppTextField(
                    suffixIconData: Icons.send_outlined,
                    onSuffixIconTap: () {
                      // Handle suffix icon tap
                    },
                    initialValue: 'Message with send button',
                  ),
                ),
              ],
            ),

            // Real Form Example Section
            _buildSection(
              title: 'Real Form Example',
              description: 'Complete form mixing different approaches',
              children: [
                ShowcaseCard(
                  title: 'Contact Form',
                  description: 'Default behavior in a real form',
                  child: Form(
                    child: Column(
                      children: [
                        AppTextField.email(),
                        AppSpacing.md.gapV,
                        AppTextField.password(),
                        AppSpacing.md.gapV,
                        AppTextFieldWrapper(
                          title: 'Phone Number',
                          isMandatory: true,
                          child: AppTextField.phone(),
                        ),
                        AppSpacing.md.gapV,
                        AppTextFieldWrapper(
                          title: 'Message',
                          description: 'Optional message or feedback',
                          child: AppTextField.multiline(
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String description,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.headlineSmall.style),
        AppSpacing.xs.gapV,
        Text(
          description,
          style: AppTextStyle.bodyMedium.style.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        AppSpacing.lg.gapV,
        ...children.map(
          (child) => Padding(
            padding: EdgeInsets.only(bottom: AppSpacing.md.value),
            child: child,
          ),
        ),
        AppSpacing.xl.gapV,
      ],
    );
  }
}
