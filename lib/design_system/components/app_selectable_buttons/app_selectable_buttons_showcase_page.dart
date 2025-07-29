import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import 'app_selectable_buttons.dart';

@RoutePage()
class SelectableButtonsShowcasePage extends StatefulWidget {
  const SelectableButtonsShowcasePage({super.key});

  @override
  State<SelectableButtonsShowcasePage> createState() =>
      _SelectableButtonsShowcasePageState();
}

class _SelectableButtonsShowcasePageState
    extends State<SelectableButtonsShowcasePage> {
  // Checkbox states
  bool _checkbox1 = false;
  bool _checkbox2 = true;
  bool _checkbox3 = false;
  bool _checkboxDisabled = true;

  // Multi-select checkbox states
  Set<String> _selectedFeatures = {'notifications', 'analytics'};
  Set<String> _selectedCategories = {'sports', 'technology'};

  // Radio button states
  String? _radioValue1 = 'option1';
  String? _radioValue2;
  String? _radioValue3 = 'tertiary2';

  // Toggle switch states
  bool _toggle1 = false;
  bool _toggle2 = true;
  bool _toggle3 = false;
  bool _toggleDisabled = true;

  // List tile states
  bool _acceptTerms = false;
  bool _receiveNewsletter = true;
  bool _enableNotifications = false;
  String? _contactMethod = 'email';
  String? _theme = 'dark';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selectable Buttons',
          style: AppTextStyle.headlineMedium.style,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.lg.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShowcaseSection(
              title: 'Checkbox Variants',
              description: 'Different styles of checkboxes for various use cases',
              children: [
                _buildCheckboxRow(
                  'Primary',
                  AppCheckbox.primary(
                    value: _checkbox1,
                    onChanged: (value) => setState(() => _checkbox1 = value ?? false),
                    semanticLabel: 'Primary checkbox example',
                  ),
                ),
                _buildCheckboxRow(
                  'Secondary',
                  AppCheckbox.secondary(
                    value: _checkbox2,
                    onChanged: (value) => setState(() => _checkbox2 = value ?? false),
                    semanticLabel: 'Secondary checkbox example',
                  ),
                ),
                _buildCheckboxRow(
                  'Tertiary',
                  AppCheckbox.tertiary(
                    value: _checkbox3,
                    onChanged: (value) => setState(() => _checkbox3 = value ?? false),
                    semanticLabel: 'Tertiary checkbox example',
                  ),
                ),
                _buildCheckboxRow(
                  'Disabled',
                  AppCheckbox.primary(
                    value: _checkboxDisabled,
                    onChanged: null, // Disabled
                    semanticLabel: 'Disabled checkbox example',
                  ),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Multi-Select Checkboxes - Selected: [${_selectedFeatures.join(', ')}]',
              description: 'Checkboxes for selecting multiple options from a group',
              children: [
                _buildMultiSelectSection(
                  'App Features',
                  [
                    ('notifications', 'Push Notifications'),
                    ('analytics', 'Usage Analytics'),
                    ('offline', 'Offline Mode'),
                    ('sync', 'Cloud Sync'),
                    ('backup', 'Auto Backup'),
                  ],
                  _selectedFeatures,
                  (value, isSelected) {
                    setState(() {
                      if (isSelected) {
                        _selectedFeatures.add(value);
                      } else {
                        _selectedFeatures.remove(value);
                      }
                    });
                  },
                ),
                AppSpacing.lg.gapV,
                _buildMultiSelectSection(
                  'Interest Categories - Selected: [${_selectedCategories.join(', ')}]',
                  [
                    ('sports', 'Sports'),
                    ('technology', 'Technology'),
                    ('music', 'Music'),
                    ('travel', 'Travel'),
                    ('food', 'Food & Cooking'),
                  ],
                  _selectedCategories,
                  (value, isSelected) {
                    setState(() {
                      if (isSelected) {
                        _selectedCategories.add(value);
                      } else {
                        _selectedCategories.remove(value);
                      }
                    });
                  },
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Radio Button Variants - Selected: [${_radioValue1 ?? 'none'}, ${_radioValue2 ?? 'none'}, ${_radioValue3 ?? 'none'}]',
              description: 'Radio buttons for single selection within groups',
              children: [
                _buildRadioSection(
                  'Primary Style',
                  [
                    ('option1', 'First Option'),
                    ('option2', 'Second Option'),
                    ('option3', 'Third Option'),
                  ],
                  _radioValue1,
                  (value) => setState(() => _radioValue1 = value),
                  AppSelectableButtonStyle.primary,
                ),
                AppSpacing.lg.gapV,
                _buildRadioSection(
                  'Secondary Style',
                  [
                    ('secondary1', 'Design'),
                    ('secondary2', 'Development'),
                    ('secondary3', 'Marketing'),
                  ],
                  _radioValue2,
                  (value) => setState(() => _radioValue2 = value),
                  AppSelectableButtonStyle.secondary,
                ),
                AppSpacing.lg.gapV,
                _buildRadioSection(
                  'Tertiary Style',
                  [
                    ('tertiary1', 'Beginner'),
                    ('tertiary2', 'Intermediate'),
                    ('tertiary3', 'Advanced'),
                  ],
                  _radioValue3,
                  (value) => setState(() => _radioValue3 = value),
                  AppSelectableButtonStyle.tertiary,
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Toggle Switch Variants',
              description: 'Toggle switches for on/off states',
              children: [
                _buildToggleRow(
                  'Primary',
                  AppToggleSwitch.primary(
                    value: _toggle1,
                    onChanged: (value) => setState(() => _toggle1 = value),
                    semanticLabel: 'Primary toggle example',
                  ),
                ),
                _buildToggleRow(
                  'Secondary',
                  AppToggleSwitch.secondary(
                    value: _toggle2,
                    onChanged: (value) => setState(() => _toggle2 = value),
                    semanticLabel: 'Secondary toggle example',
                  ),
                ),
                _buildToggleRow(
                  'Tertiary',
                  AppToggleSwitch.tertiary(
                    value: _toggle3,
                    onChanged: (value) => setState(() => _toggle3 = value),
                    semanticLabel: 'Tertiary toggle example',
                  ),
                ),
                _buildToggleRow(
                  'Disabled',
                  AppToggleSwitch.primary(
                    value: _toggleDisabled,
                    onChanged: null, // Disabled
                    semanticLabel: 'Disabled toggle example',
                  ),
                ),
                _buildToggleRow(
                  'Custom Size',
                  AppToggleSwitch.primary(
                    value: _toggle1,
                    width: 60,
                    height: 30,
                    onChanged: (value) => setState(() => _toggle1 = value),
                    semanticLabel: 'Large toggle example',
                  ),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'List Tiles - Checkboxes',
              description: 'Checkboxes integrated with list tiles for better UX',
              children: [
                AppCheckboxListTile(
                  value: _acceptTerms,
                  title: const Text('Accept Terms and Conditions'),
                  subtitle: const Text('Required to continue with registration'),
                  style: AppSelectableButtonStyle.primary,
                  onChanged: (value) => setState(() => _acceptTerms = value ?? false),
                ),
                AppCheckboxListTile(
                  value: _receiveNewsletter,
                  title: const Text('Receive Newsletter'),
                  subtitle: const Text('Get weekly updates about new features'),
                  style: AppSelectableButtonStyle.secondary,
                  controlAffinity: true, // Control on the right
                  onChanged: (value) => setState(() => _receiveNewsletter = value ?? false),
                ),
                AppCheckboxListTile(
                  value: _enableNotifications,
                  title: const Text('Enable Push Notifications'),
                  subtitle: const Text('Get notified about important updates'),
                  style: AppSelectableButtonStyle.tertiary,
                  onChanged: (value) => setState(() => _enableNotifications = value ?? false),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'List Tiles - Radio Buttons - Contact: ${_contactMethod ?? 'none'}, Theme: ${_theme ?? 'none'}',
              description: 'Radio buttons integrated with list tiles',
              children: [
                Text(
                  'Contact Method',
                  style: AppTextStyle.labelLarge.style,
                ),
                AppSpacing.sm.gapV,
                AppRadioListTile<String>(
                  value: 'email',
                  groupValue: _contactMethod,
                  title: const Text('Email'),
                  subtitle: const Text('Receive updates via email'),
                  style: AppSelectableButtonStyle.primary,
                  onChanged: (value) => setState(() => _contactMethod = value),
                ),
                AppRadioListTile<String>(
                  value: 'sms',
                  groupValue: _contactMethod,
                  title: const Text('SMS'),
                  subtitle: const Text('Receive updates via text message'),
                  style: AppSelectableButtonStyle.primary,
                  onChanged: (value) => setState(() => _contactMethod = value),
                ),
                AppRadioListTile<String>(
                  value: 'phone',
                  groupValue: _contactMethod,
                  title: const Text('Phone Call'),
                  subtitle: const Text('Receive updates via phone call'),
                  style: AppSelectableButtonStyle.primary,
                  controlAffinity: true, // Control on the right
                  onChanged: (value) => setState(() => _contactMethod = value),
                ),
                AppSpacing.lg.gapV,
                Text(
                  'Theme Preference',
                  style: AppTextStyle.labelLarge.style,
                ),
                AppSpacing.sm.gapV,
                AppRadioListTile<String>(
                  value: 'light',
                  groupValue: _theme,
                  title: const Text('Light Theme'),
                  style: AppSelectableButtonStyle.secondary,
                  onChanged: (value) => setState(() => _theme = value),
                ),
                AppRadioListTile<String>(
                  value: 'dark',
                  groupValue: _theme,
                  title: const Text('Dark Theme'),
                  style: AppSelectableButtonStyle.secondary,
                  onChanged: (value) => setState(() => _theme = value),
                ),
                AppRadioListTile<String>(
                  value: 'system',
                  groupValue: _theme,
                  title: const Text('System Default'),
                  style: AppSelectableButtonStyle.secondary,
                  onChanged: (value) => setState(() => _theme = value),
                ),
              ],
            ),

            ShowcaseSection(
              title: 'Form Integration Example',
              description: 'Real-world form with mixed selectable components',
              children: [
                _buildFormExample(),
              ],
            ),

            ShowcaseSection(
              title: 'Accessibility Features',
              description: 'Components with semantic labels for screen readers',
              children: [
                Text(
                  'All components include proper semantic labels and keyboard navigation support.',
                  style: AppTextStyle.bodyMedium.style,
                ),
                AppSpacing.md.gapV,
                Row(
                  children: [
                    AppCheckbox.primary(
                      value: true,
                      onChanged: (_) {},
                      semanticLabel: 'Enable accessibility features',
                    ),
                    AppSpacing.md.gapH,
                    const Text('Screen reader accessible checkbox'),
                  ],
                ),
                AppSpacing.md.gapV,
                Row(
                  children: [
                    AppToggleSwitch.primary(
                      value: true,
                      onChanged: (_) {},
                      semanticLabel: 'High contrast mode toggle',
                    ),
                    AppSpacing.md.gapH,
                    const Text('High contrast mode'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxRow(String label, AppCheckbox checkbox) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: AppTextStyle.labelMedium.style),
          ),
          AppSpacing.md.gapH,
          checkbox,
          AppSpacing.md.gapH,
          Text(
            checkbox.value ? 'Checked' : 'Unchecked',
            style: AppTextStyle.bodySmall.style,
          ),
        ],
      ),
    );
  }

  Widget _buildRadioSection(
    String title,
    List<(String, String)> options,
    String? groupValue,
    ValueChanged<String?> onChanged,
    AppSelectableButtonStyle style,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.labelLarge.style),
        AppSpacing.sm.gapV,
        ...options.map((option) => Padding(
              padding: AppSpacing.xs.paddingVertical,
              child: Row(
                children: [
                  AppRadioButton<String>(
                    value: option.$1,
                    groupValue: groupValue,
                    style: style,
                    onChanged: onChanged,
                    semanticLabel: '${option.$2} radio button',
                  ),
                  AppSpacing.md.gapH,
                  Text(option.$2),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildToggleRow(String label, AppToggleSwitch toggle) {
    return Padding(
      padding: AppSpacing.sm.paddingVertical,
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: AppTextStyle.labelMedium.style),
          ),
          AppSpacing.md.gapH,
          toggle,
          AppSpacing.md.gapH,
          Text(
            toggle.value ? 'On' : 'Off',
            style: AppTextStyle.bodySmall.style,
          ),
        ],
      ),
    );
  }

  Widget _buildFormExample() {
    return Container(
      padding: AppSpacing.md.padding,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'User Preferences',
            style: AppTextStyle.headlineSmall.style,
          ),
          AppSpacing.md.gapV,
          
          // Checkboxes section
          Text('Notification Settings', style: AppTextStyle.labelLarge.style),
          AppSpacing.sm.gapV,
          AppCheckboxListTile(
            value: _acceptTerms,
            title: const Text('Email notifications'),
            subtitle: const Text('Receive updates via email'),
            onChanged: (value) => setState(() => _acceptTerms = value ?? false),
          ),
          AppCheckboxListTile(
            value: _receiveNewsletter,
            title: const Text('Push notifications'),
            subtitle: const Text('Receive push notifications on mobile'),
            onChanged: (value) => setState(() => _receiveNewsletter = value ?? false),
          ),
          
          AppSpacing.lg.gapV,
          
          // Radio buttons section
          Text('Preferred Contact Time', style: AppTextStyle.labelLarge.style),
          AppSpacing.sm.gapV,
          ...['morning', 'afternoon', 'evening'].map((time) =>
            AppRadioListTile<String>(
              value: time,
              groupValue: _contactMethod == time ? time : null,
              title: Text(time.replaceFirst(time[0], time[0].toUpperCase())),
              onChanged: (value) => setState(() => _contactMethod = value),
            ),
          ),
          
          AppSpacing.lg.gapV,
          
          // Toggle switches section
          Text('Privacy Settings', style: AppTextStyle.labelLarge.style),
          AppSpacing.sm.gapV,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Make profile public'),
              AppToggleSwitch.primary(
                value: _toggle1,
                onChanged: (value) => setState(() => _toggle1 = value),
              ),
            ],
          ),
          AppSpacing.md.gapV,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Allow data analytics'),
              AppToggleSwitch.secondary(
                value: _toggle2,
                onChanged: (value) => setState(() => _toggle2 = value),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMultiSelectSection(
    String title,
    List<(String, String)> options,
    Set<String> selectedValues,
    Function(String, bool) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.labelLarge.style),
        AppSpacing.sm.gapV,
        Container(
          padding: AppSpacing.md.padding,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: options.map((option) {
              final isSelected = selectedValues.contains(option.$1);
              return AppCheckboxListTile(
                value: isSelected,
                title: Text(option.$2),
                subtitle: Text('Value: ${option.$1}'),
                style: AppSelectableButtonStyle.primary,
                onChanged: (value) => onChanged(option.$1, value ?? false),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}