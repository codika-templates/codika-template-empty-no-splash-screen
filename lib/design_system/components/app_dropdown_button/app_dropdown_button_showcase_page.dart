import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_spacing.dart';
import '../app_text_field/app_text_field.dart';
import '../app_text_field/app_text_field_wrapper.dart';
import 'app_dropdown_button.dart';
import 'app_dropdown_item.dart';

@RoutePage()
class AppDropdownButtonShowcasePage extends StatefulWidget {
  const AppDropdownButtonShowcasePage({super.key});

  @override
  State<AppDropdownButtonShowcasePage> createState() =>
      _AppDropdownButtonShowcasePageState();
}

class _AppDropdownButtonShowcasePageState
    extends State<AppDropdownButtonShowcasePage> {
  // Sample data
  final List<AppDropdownItem<String>> _fruits = [
    AppDropdownItem(
      value: 'apple',
      label: 'Apple',
      leadingIcon: const Icon(Icons.apple, color: Colors.red),
    ),
    AppDropdownItem(
      value: 'banana',
      label: 'Banana',
      leadingIcon: const Icon(Icons.eco, color: Colors.yellow),
    ),
    AppDropdownItem(
      value: 'orange',
      label: 'Orange',
      leadingIcon: const Icon(Icons.circle, color: Colors.orange),
    ),
    AppDropdownItem(
      value: 'grape',
      label: 'Grape',
      leadingIcon: const Icon(Icons.circle, color: Colors.purple),
    ),
  ];

  final List<AppDropdownItem<Country>> _countries = [
    AppDropdownItem(
      value: Country('US', 'United States'),
      label: 'United States',
      leadingIcon: const Text('🇺🇸', style: TextStyle(fontSize: 20)),
    ),
    AppDropdownItem(
      value: Country('CA', 'Canada'),
      label: 'Canada',
      leadingIcon: const Text('🇨🇦', style: TextStyle(fontSize: 20)),
    ),
    AppDropdownItem(
      value: Country('GB', 'United Kingdom'),
      label: 'United Kingdom',
      leadingIcon: const Text('🇬🇧', style: TextStyle(fontSize: 20)),
    ),
    AppDropdownItem(
      value: Country('FR', 'France'),
      label: 'France',
      leadingIcon: const Text('🇫🇷', style: TextStyle(fontSize: 20)),
    ),
    AppDropdownItem(
      value: Country('DE', 'Germany'),
      label: 'Germany',
      leadingIcon: const Text('🇩🇪', style: TextStyle(fontSize: 20)),
    ),
  ];

  final List<AppDropdownItem<Priority>> _priorities = [
    AppDropdownItem(
      value: Priority.low,
      label: 'Low Priority',
      leadingIcon: const Icon(Icons.low_priority, color: Colors.green),
      trailingIcon: const Icon(Icons.keyboard_arrow_right, size: 16),
    ),
    AppDropdownItem(
      value: Priority.medium,
      label: 'Medium Priority',
      leadingIcon: const Icon(Icons.priority_high, color: Colors.orange),
      trailingIcon: const Icon(Icons.keyboard_arrow_right, size: 16),
    ),
    AppDropdownItem(
      value: Priority.high,
      label: 'High Priority',
      leadingIcon: const Icon(Icons.priority_high, color: Colors.red),
      trailingIcon: const Icon(Icons.keyboard_arrow_right, size: 16),
    ),
    AppDropdownItem(
      value: Priority.urgent,
      label: 'Urgent',
      leadingIcon: const Icon(Icons.warning, color: Colors.redAccent),
      trailingIcon: const Icon(Icons.keyboard_arrow_right, size: 16),
    ),
  ];

  // Long string examples
  final List<AppDropdownItem<String>> _longOptions = [
    AppDropdownItem(
      value: 'short',
      label: 'Short option',
    ),
    AppDropdownItem(
      value: 'medium',
      label: 'This is a medium length option that shows normal text',
    ),
    AppDropdownItem(
      value: 'long',
      label: 'This is a very long option text that demonstrates how the dropdown handles overflow and text wrapping behavior in the dropdown menu items',
    ),
    AppDropdownItem(
      value: 'extremelylong',
      label: 'This is an extremely long option text that really pushes the boundaries of what should be displayed in a dropdown menu and tests the text overflow, ellipsis, and general user experience when dealing with verbose option labels that might come from user-generated content or detailed descriptions',
    ),
  ];

  // Enum example using UserRole
  final List<AppDropdownItem<UserRole>> _userRoles = [
    AppDropdownItem(
      value: UserRole.admin,
      label: 'Administrator',
      leadingIcon: const Icon(Icons.admin_panel_settings, color: Colors.red),
    ),
    AppDropdownItem(
      value: UserRole.moderator,
      label: 'Moderator',
      leadingIcon: const Icon(Icons.shield, color: Colors.orange),
    ),
    AppDropdownItem(
      value: UserRole.user,
      label: 'User',
      leadingIcon: const Icon(Icons.person, color: Colors.blue),
    ),
    AppDropdownItem(
      value: UserRole.guest,
      label: 'Guest',
      leadingIcon: const Icon(Icons.person_outline, color: Colors.grey),
    ),
  ];

  // Large list of 30 alphabet options
  List<AppDropdownItem<String>> get _alphabetOptions {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final items = <AppDropdownItem<String>>[];
    
    // Add single letters A-Z
    for (int i = 0; i < alphabet.length; i++) {
      final letter = alphabet[i];
      items.add(AppDropdownItem(
        value: letter.toLowerCase(),
        label: 'Option $letter',
      ));
    }
    
    // Add some double letters for 30+ items
    items.addAll([
      AppDropdownItem(value: 'aa', label: 'Option AA'),
      AppDropdownItem(value: 'bb', label: 'Option BB'),
      AppDropdownItem(value: 'cc', label: 'Option CC'),
      AppDropdownItem(value: 'dd', label: 'Option DD'),
    ]);
    
    return items;
  }

  // State variables
  String? _selectedFruit;
  Country? _selectedCountry;
  Priority? _selectedPriority;
  String? _selectedFruitFilled;
  String? _selectedFruitUnderlined;
  String? _selectedFruitSmall;
  String? _selectedFruitLarge;
  String? _selectedFruitWithSearch;
  String? _selectedFruitWithError;
  String? _selectedLongOption;
  UserRole? _selectedUserRole;
  String? _selectedAlphabetOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppDropdownButton Showcase'),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.lg.padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic Usage
            ShowcaseSection(
              title: 'Basic Usage',
              description: 'Simple dropdown with string values',
              children: [
                AppDropdownButton<String>(
                  items: _fruits,
                  value: _selectedFruit,
                  onSelected: (value) => setState(() => _selectedFruit = value),
                  hintText: 'Select a fruit',
                ),
                AppSpacing.md.gapV,
                if (_selectedFruit != null)
                  Text('Selected: $_selectedFruit'),
              ],
            ),

            AppSpacing.xl.gapV,

            // Variants
            ShowcaseSection(
              title: 'Variants',
              description: 'Different visual styles matching AppTextField',
              children: [
                // Outlined (default)
                AppDropdownButton.outlined(
                  items: _fruits,
                  value: _selectedFruit,
                  onSelected: (value) => setState(() => _selectedFruit = value),
                  hintText: 'Outlined (default)',
                ),
                AppSpacing.md.gapV,
                
                // Filled
                AppDropdownButton.filled(
                  items: _fruits,
                  value: _selectedFruitFilled,
                  onSelected: (value) => setState(() => _selectedFruitFilled = value),
                  hintText: 'Filled variant',
                ),
                AppSpacing.md.gapV,
                
                // Underlined
                AppDropdownButton<String>(
                  variant: AppTextFieldVariant.underlined,
                  items: _fruits,
                  value: _selectedFruitUnderlined,
                  onSelected: (value) => setState(() => _selectedFruitUnderlined = value),
                  hintText: 'Underlined variant',
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            // Sizes
            ShowcaseSection(
              title: 'Sizes',
              description: 'Different sizes matching AppTextField',
              children: [
                // Small
                AppDropdownButton<String>(
                  size: AppTextFieldSize.sm,
                  items: _fruits,
                  value: _selectedFruitSmall,
                  onSelected: (value) => setState(() => _selectedFruitSmall = value),
                  hintText: 'Small size',
                ),
                AppSpacing.md.gapV,
                
                // Medium (default)
                AppDropdownButton<String>(
                  size: AppTextFieldSize.md,
                  items: _fruits,
                  value: _selectedFruit,
                  onSelected: (value) => setState(() => _selectedFruit = value),
                  hintText: 'Medium size (default)',
                ),
                AppSpacing.md.gapV,
                
                // Large
                AppDropdownButton<String>(
                  size: AppTextFieldSize.lg,
                  items: _fruits,
                  value: _selectedFruitLarge,
                  onSelected: (value) => setState(() => _selectedFruitLarge = value),
                  hintText: 'Large size',
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            // With AppTextFieldWrapper
            ShowcaseSection(
              title: 'With AppTextFieldWrapper',
              description: 'Using external labels and descriptions',
              children: [
                AppTextFieldWrapper(
                  title: 'Country Selection',
                  isMandatory: true,
                  description: 'Select your country of residence',
                  child: AppDropdownButton<Country>(
                    items: _countries,
                    value: _selectedCountry,
                    onSelected: (value) => setState(() => _selectedCountry = value),
                    hintText: 'Select country',
                  ),
                ),
                AppSpacing.md.gapV,
                if (_selectedCountry != null)
                  Text('Selected: ${_selectedCountry!.name} (${_selectedCountry!.code})'),
              ],
            ),

            AppSpacing.xl.gapV,

            // Rich Items with Icons
            ShowcaseSection(
              title: 'Rich Items with Icons',
              description: 'Dropdown items with leading and trailing icons',
              children: [
                AppDropdownButton<Priority>(
                  items: _priorities,
                  value: _selectedPriority,
                  onSelected: (value) => setState(() => _selectedPriority = value),
                  hintText: 'Select priority level',
                ),
                AppSpacing.md.gapV,
                if (_selectedPriority != null)
                  Text('Selected: ${_selectedPriority!.name}'),
              ],
            ),

            AppSpacing.xl.gapV,

            // With Search
            ShowcaseSection(
              title: 'With Search & Filter',
              description: 'Searchable and filterable dropdown',
              children: [
                AppDropdownButton<String>(
                  items: _fruits,
                  value: _selectedFruitWithSearch,
                  onSelected: (value) => setState(() => _selectedFruitWithSearch = value),
                  hintText: 'Search fruits...',
                  enableSearch: true,
                  enableFilter: true,
                ),
                AppSpacing.md.gapV,
                if (_selectedFruitWithSearch != null)
                  Text('Selected: $_selectedFruitWithSearch'),
              ],
            ),

            AppSpacing.xl.gapV,

            // Error State
            ShowcaseSection(
              title: 'Error State',
              description: 'Dropdown with error styling',
              children: [
                AppDropdownButton<String>(
                  items: _fruits,
                  value: _selectedFruitWithError,
                  onSelected: (value) => setState(() => _selectedFruitWithError = value),
                  hintText: 'Select a fruit',
                  errorText: _selectedFruitWithError == null 
                      ? 'Please select a fruit' 
                      : null,
                ),
                AppSpacing.md.gapV,
                if (_selectedFruitWithError != null)
                  Text('Selected: $_selectedFruitWithError'),
              ],
            ),

            AppSpacing.xl.gapV,

            // Disabled State
            ShowcaseSection(
              title: 'Disabled State',
              description: 'Disabled dropdown',
              children: [
                AppDropdownButton<String>(
                  items: _fruits,
                  value: null,
                  onSelected: null,
                  hintText: 'Disabled dropdown',
                  enabled: false,
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            // Long String Example
            ShowcaseSection(
              title: 'Long Text Handling',
              description: 'How the dropdown handles long option text and overflow',
              children: [
                AppDropdownButton<String>(
                  items: _longOptions,
                  value: _selectedLongOption,
                  onSelected: (value) => setState(() => _selectedLongOption = value),
                  hintText: 'Select option with varying text lengths',
                ),
                AppSpacing.md.gapV,
                if (_selectedLongOption != null)
                  Text('Selected: $_selectedLongOption'),
              ],
            ),

            AppSpacing.xl.gapV,

            // Enum Example
            ShowcaseSection(
              title: 'Enum Values Example',
              description: 'Using dropdown with enum values for type safety',
              children: [
                AppDropdownButton<UserRole>(
                  items: _userRoles,
                  value: _selectedUserRole,
                  onSelected: (value) => setState(() => _selectedUserRole = value),
                  hintText: 'Select user role',
                ),
                AppSpacing.md.gapV,
                if (_selectedUserRole != null)
                  Text('Selected: ${_selectedUserRole!.name} (${_selectedUserRole!.description})'),
              ],
            ),

            AppSpacing.xl.gapV,

            // Large List Example
            ShowcaseSection(
              title: 'Large List with Scrolling',
              description: '30+ options demonstrating scrollable dropdown behavior',
              children: [
                AppDropdownButton<String>(
                  items: _alphabetOptions,
                  value: _selectedAlphabetOption,
                  onSelected: (value) => setState(() => _selectedAlphabetOption = value),
                  hintText: 'Select from 30+ alphabet options',
                  menuHeight: 200, // Limit height to show scrolling
                ),
                AppSpacing.md.gapV,
                if (_selectedAlphabetOption != null)
                  Text('Selected: $_selectedAlphabetOption'),
              ],
            ),

            AppSpacing.xl.gapV,

            // Selection-Only Behavior
            ShowcaseSection(
              title: 'Selection-Only Behavior (Default)',
              description: 'Click to select from list - no typing allowed by default',
              children: [
                AppDropdownButton<String>(
                  items: _fruits,
                  value: _selectedFruit,
                  onSelected: (value) => setState(() => _selectedFruit = value),
                  hintText: 'Click to select (no typing)',
                ),
                AppSpacing.md.gapV,
                Text(
                  'Notice: Field shows pointer cursor and hover effect. No typing allowed.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            AppSpacing.xl.gapV,

            // Comparison with AppTextField
            ShowcaseSection(
              title: 'Comparison with AppTextField',
              description: 'Visual consistency between dropdown and text field',
              children: [
                AppTextField(
                  hintText: 'Regular text field (typing allowed)',
                  variant: AppTextFieldVariant.outlined,
                ),
                AppSpacing.md.gapV,
                AppDropdownButton<String>(
                  items: _fruits,
                  value: _selectedFruit,
                  onSelected: (value) => setState(() => _selectedFruit = value),
                  hintText: 'Dropdown with same styling (selection only)',
                  variant: AppTextFieldVariant.outlined,
                ),
              ],
            ),

            AppSpacing.xxxl.gapV,
          ],
        ),
      ),
    );
  }
}

// Sample data classes
class Country {
  final String code;
  final String name;

  Country(this.code, this.name);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Country && other.code == code && other.name == name;
  }

  @override
  int get hashCode => Object.hash(code, name);

  @override
  String toString() => 'Country(code: $code, name: $name)';
}

enum Priority { low, medium, high, urgent }

enum UserRole { 
  admin, 
  moderator, 
  user, 
  guest;
  
  String get description {
    switch (this) {
      case UserRole.admin:
        return 'Full system access and management';
      case UserRole.moderator:
        return 'Content moderation and user management';
      case UserRole.user:
        return 'Standard user with basic permissions';
      case UserRole.guest:
        return 'Limited access, view-only permissions';
    }
  }
}