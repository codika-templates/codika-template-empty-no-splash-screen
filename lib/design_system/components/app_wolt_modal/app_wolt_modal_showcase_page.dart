import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../../playground/widgets/showcase_section.dart';
import '../../tokens/app_spacing.dart';
import '../../tokens/app_typography.dart';
import '../app_button/app_button.dart';
import 'app_wolt_modal.dart';
import 'app_wolt_modal_page.dart';

@RoutePage()
class WoltModalShowcasePage extends StatefulWidget {
  const WoltModalShowcasePage({super.key});

  @override
  State<WoltModalShowcasePage> createState() => _WoltModalShowcasePageState();
}

class _WoltModalShowcasePageState extends State<WoltModalShowcasePage> {
  final ValueNotifier<int> _pageIndexNotifier = ValueNotifier<int>(0);
  final ValueNotifier<String> _formData = ValueNotifier<String>('');

  // Track active async operations to prevent context usage after dispose
  final Set<Future> _activeOperations = {};

  @override
  void dispose() {
    _pageIndexNotifier.dispose();
    _formData.dispose();
    // Cancel any pending operations
    _activeOperations.clear();
    super.dispose();
  }

  // Helper methods to safely handle navigation
  void _safeSetPageIndex(int index) {
    if (mounted) {
      _pageIndexNotifier.value = index;
    }
  }

  void _safePopModal() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wolt Modal Showcase',
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
            Text(
              'Advanced multi-page modals with smooth navigation and animations.',
              style: AppTextStyle.bodyLarge.style,
            ),
            AppSpacing.xl.gapV,
            _buildBasicExamples(),
            AppSpacing.xl.gapV,
            _buildWorkflowExamples(),
            AppSpacing.xl.gapV,
            _buildAdvancedExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicExamples() {
    return ShowcaseSection(
      title: 'Basic Examples',
      children: [
        AppButton.primary(
          onPressed: _showSimpleModal,
          child: const Text('Simple Modal'),
        ),
        AppSpacing.md.gapV,
        AppButton.primary(
          onPressed: _showMultiPageModal,
          child: const Text('Multi-Page Modal'),
        ),
        AppSpacing.md.gapV,
        AppButton.primary(
          onPressed: _showFormModal,
          child: const Text('Form Modal'),
        ),
      ],
    );
  }

  Widget _buildWorkflowExamples() {
    return ShowcaseSection(
      title: 'Workflow Examples',
      children: [
        AppButton.primary(
          onPressed: _showOnboardingFlow,
          child: const Text('Onboarding Flow'),
        ),
        AppSpacing.md.gapV,
        AppButton.primary(
          onPressed: _showCheckoutFlow,
          child: const Text('E-commerce Checkout'),
        ),
        AppSpacing.md.gapV,
        AppButton.primary(
          onPressed: _showSettingsFlow,
          child: const Text('Settings Wizard'),
        ),
      ],
    );
  }

  Widget _buildAdvancedExamples() {
    return ShowcaseSection(
      title: 'Advanced Examples',
      children: [
        AppButton.primary(
          onPressed: _showImageGallery,
          child: const Text('Image Gallery'),
        ),
        AppSpacing.md.gapV,
        AppButton.primary(
          onPressed: _showComplexForm,
          child: const Text('Complex Form Wizard'),
        ),
        AppSpacing.md.gapV,
        AppButton.primary(
          onPressed: _showLoadingFlow,
          child: const Text('Loading & Progress Flow'),
        ),
      ],
    );
  }

  // Basic Examples
  void _showSimpleModal() {
    AppWoltModal.simple(
      context: context,
      title: 'Simple Modal',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.info, size: 48, color: Colors.blue),
          SizedBox(height: 16),
          Text(
            'This is a simple modal built with Wolt Modal Sheet. It adapts to screen size - showing as a dialog on desktop and bottom sheet on mobile.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      primaryAction: AppButton.primary(
        onPressed: _safePopModal,
        child: const Text('Got it'),
      ),
    );
  }

  void _showMultiPageModal() {
    _pageIndexNotifier.value = 0;

    AppWoltModal.showPages(
      context: context,
      pageIndexNotifier: _pageIndexNotifier,
      pages: [_createPage1(), _createPage2(), _createPage3()],
    );
  }

  void _showFormModal() {
    AppWoltModal.form(
      context: context,
      title: 'Contact Form',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          AppSpacing.md.gapV,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
          ),
          AppSpacing.md.gapV,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
        ],
      ),
      primaryAction: AppButton.primary(
        onPressed: _safePopModal,
        child: const Text('Send'),
      ),
      secondaryAction: AppButton.secondary(
        onPressed: _safePopModal,
        child: const Text('Cancel'),
      ),
    );
  }

  // Workflow Examples
  void _showOnboardingFlow() {
    _pageIndexNotifier.value = 0;

    AppWoltModal.workflow(
      context: context,
      pageIndexNotifier: _pageIndexNotifier,
      pages: [
        _createOnboardingPage1(),
        _createOnboardingPage2(),
        _createOnboardingPage3(),
      ],
    );
  }

  void _showCheckoutFlow() {
    _pageIndexNotifier.value = 0;

    AppWoltModal.workflow(
      context: context,
      pageIndexNotifier: _pageIndexNotifier,
      pages: [
        _createCheckoutPage1(),
        _createCheckoutPage2(),
        _createCheckoutPage3(),
      ],
    );
  }

  void _showSettingsFlow() {
    _pageIndexNotifier.value = 0;

    AppWoltModal.workflow(
      context: context,
      pageIndexNotifier: _pageIndexNotifier,
      pages: [
        _createSettingsPage1(),
        _createSettingsPage2(),
        _createSettingsPage3(),
      ],
    );
  }

  // Advanced Examples
  void _showImageGallery() {
    _pageIndexNotifier.value = 0;

    AppWoltModal.showPages(
      context: context,
      pageIndexNotifier: _pageIndexNotifier,
      pages: [
        _createGalleryPage1(),
        _createGalleryPage2(),
        _createGalleryPage3(),
      ],
    );
  }

  void _showComplexForm() {
    _pageIndexNotifier.value = 0;

    AppWoltModal.workflow(
      context: context,
      pageIndexNotifier: _pageIndexNotifier,
      pages: [
        _createComplexFormPage1(),
        _createComplexFormPage2(),
        _createComplexFormPage3(),
        _createComplexFormPage4(),
      ],
    );
  }

  void _showLoadingFlow() {
    AppWoltModal.loading(
      context: context,
      title: 'Processing',
      subtitle: 'Please wait while we process your request...',
      onCancel: () {
        _safePopModal();
        // Clear any pending operations when cancelled
        _activeOperations.clear();
      },
    );

    // Simulate processing with proper lifecycle management
    late final Future<void> operation;
    operation = Future.delayed(const Duration(seconds: 3), () {
      // Check if widget is still mounted and operation wasn't cancelled
      if (mounted && _activeOperations.contains(operation)) {
        _safePopModal();
        _showProcessingComplete();
      }
    });

    // Track this operation
    _activeOperations.add(operation);

    // Clean up when done
    operation.whenComplete(() => _activeOperations.remove(operation));
  }

  void _showProcessingComplete() {
    // Double-check that widget is still mounted
    if (!mounted) return;

    AppWoltModal.simple(
      context: context,
      title: 'Complete!',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 64, color: Colors.green),
          SizedBox(height: 16),
          Text('Your request has been processed successfully!'),
        ],
      ),
      primaryAction: AppButton.primary(
        onPressed: _safePopModal,
        child: const Text('Done'),
      ),
    );
  }

  // Page Builders - Basic Multi-Page Modal
  WoltModalSheetPage _createPage1() {
    return AppWoltModalPage.standard(
      id: 'page1',
      title: 'Welcome',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.waving_hand, size: 48, color: Colors.orange),
          SizedBox(height: 16),
          Text(
            'Welcome to our multi-page modal! This demonstrates smooth navigation between pages with animations.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Next'),
        ),
        secondary: AppButton.secondary(
          onPressed: _safePopModal,
          child: const Text('Close'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createPage2() {
    return AppWoltModalPage.standard(
      id: 'page2',
      title: 'Features',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Key Features:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          ListTile(
            leading: Icon(Icons.phone_android, color: Colors.blue),
            title: Text('Responsive Design'),
            subtitle: Text('Adapts to screen size automatically'),
          ),
          ListTile(
            leading: Icon(Icons.animation, color: Colors.purple),
            title: Text('Smooth Animations'),
            subtitle: Text('Beautiful page transitions'),
          ),
          ListTile(
            leading: Icon(Icons.navigation, color: Colors.green),
            title: Text('Easy Navigation'),
            subtitle: Text('Intuitive page flow controls'),
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(2),
          child: const Text('Next'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(0),
          child: const Text('Back'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createPage3() {
    return AppWoltModalPage.standard(
      id: 'page3',
      title: 'Complete',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.celebration, size: 48, color: Colors.purple),
          SizedBox(height: 16),
          Text(
            'You\'ve completed the tour! This modal can be used for onboarding, forms, galleries, and much more.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: _safePopModal,
          child: const Text('Finish'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Back'),
        ),
      ),
    );
  }

  // Onboarding Flow Pages
  WoltModalSheetPage _createOnboardingPage1() {
    return AppWoltModalPage.standard(
      id: 'onboarding1',
      title: 'Welcome to Our App',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.rocket_launch, size: 64, color: Colors.blue),
          SizedBox(height: 24),
          Text(
            'Get ready to experience something amazing! Let us show you around.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Get Started'),
        ),
        secondary: AppButton.secondary(
          onPressed: _safePopModal,
          child: const Text('Skip'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createOnboardingPage2() {
    return AppWoltModalPage.standard(
      id: 'onboarding2',
      title: 'Powerful Features',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, size: 64, color: Colors.purple),
          SizedBox(height: 24),
          Text(
            'Our app is packed with features designed to make your life easier and more productive.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              Chip(label: Text('Fast')),
              Chip(label: Text('Reliable')),
              Chip(label: Text('Secure')),
              Chip(label: Text('Beautiful')),
            ],
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(2),
          child: const Text('Continue'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(0),
          child: const Text('Back'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createOnboardingPage3() {
    return AppWoltModalPage.standard(
      id: 'onboarding3',
      title: 'Ready to Begin?',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          SizedBox(height: 24),
          Text(
            'You\'re all set! Start exploring and make the most of your new app.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: _safePopModal,
          child: const Text('Let\'s Go!'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Back'),
        ),
      ),
    );
  }

  // Checkout Flow Pages
  WoltModalSheetPage _createCheckoutPage1() {
    return AppWoltModalPage.standard(
      id: 'checkout1',
      title: 'Your Cart',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: ListTile(
              leading: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: const Icon(Icons.shopping_bag),
              ),
              title: const Text('Premium Package'),
              subtitle: const Text('Includes all features'),
              trailing: const Text('\$29.99'),
            ),
          ),
          AppSpacing.md.gapV,
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total:', style: AppTextStyle.titleMedium.style),
              Text('\$29.99', style: AppTextStyle.titleMedium.style),
            ],
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Continue to Payment'),
        ),
        secondary: AppButton.secondary(
          onPressed: _safePopModal,
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createCheckoutPage2() {
    return AppWoltModalPage.form(
      id: 'checkout2',
      title: 'Payment Details',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Card Number',
              hintText: '1234 5678 9012 3456',
              prefixIcon: Icon(Icons.credit_card),
              border: OutlineInputBorder(),
            ),
          ),
          AppSpacing.md.gapV,
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Expiry',
                    hintText: 'MM/YY',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              AppSpacing.md.gapH,
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    hintText: '123',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      primaryAction: AppButton.primary(
        onPressed: () => _safeSetPageIndex(2),
        child: const Text('Pay Now'),
      ),
      secondaryAction: AppButton.secondary(
        onPressed: () => _safeSetPageIndex(0),
        child: const Text('Back'),
      ),
    );
  }

  WoltModalSheetPage _createCheckoutPage3() {
    return AppWoltModalPage.standard(
      id: 'checkout3',
      title: 'Payment Successful!',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.payment, size: 64, color: Colors.green),
          SizedBox(height: 24),
          Text(
            'Thank you for your purchase! Your payment has been processed successfully.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            'Order #12345',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: _safePopModal,
          child: const Text('Done'),
        ),
      ),
    );
  }

  // Settings Flow Pages
  WoltModalSheetPage _createSettingsPage1() {
    return AppWoltModalPage.standard(
      id: 'settings1',
      title: 'Preferences',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            title: const Text('Enable Notifications'),
            subtitle: const Text('Receive app notifications'),
            value: true,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Use dark theme'),
            value: false,
            onChanged: (value) {},
          ),
          SwitchListTile(
            title: const Text('Auto-save'),
            subtitle: const Text('Automatically save changes'),
            value: true,
            onChanged: (value) {},
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Next'),
        ),
        secondary: AppButton.secondary(
          onPressed: _safePopModal,
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createSettingsPage2() {
    return AppWoltModalPage.standard(
      id: 'settings2',
      title: 'Privacy',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile(
            title: const Text('Public'),
            subtitle: const Text('Anyone can see your profile'),
            value: 'public',
            groupValue: 'private',
            onChanged: (value) {},
          ),
          RadioListTile(
            title: const Text('Friends Only'),
            subtitle: const Text('Only friends can see your profile'),
            value: 'friends',
            groupValue: 'private',
            onChanged: (value) {},
          ),
          RadioListTile(
            title: const Text('Private'),
            subtitle: const Text('Only you can see your profile'),
            value: 'private',
            groupValue: 'private',
            onChanged: (value) {},
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(2),
          child: const Text('Next'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(0),
          child: const Text('Back'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createSettingsPage3() {
    return AppWoltModalPage.standard(
      id: 'settings3',
      title: 'All Set!',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.settings, size: 64, color: Colors.blue),
          SizedBox(height: 24),
          Text(
            'Your settings have been configured. You can always change them later.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: _safePopModal,
          child: const Text('Save & Close'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Back'),
        ),
      ),
    );
  }

  // Gallery Pages
  WoltModalSheetPage _createGalleryPage1() {
    return AppWoltModalPage.standard(
      id: 'gallery1',
      title: 'Mountain Landscape',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.landscape, size: 64),
          ),
          AppSpacing.md.gapV,
          const Text(
            'Beautiful mountain landscape taken during sunrise. The perfect blend of colors and natural beauty.',
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Next Photo'),
        ),
        secondary: AppButton.secondary(
          onPressed: _safePopModal,
          child: const Text('Close'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createGalleryPage2() {
    return AppWoltModalPage.standard(
      id: 'gallery2',
      title: 'Ocean View',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.waves, size: 64, color: Colors.blue),
          ),
          AppSpacing.md.gapV,
          const Text(
            'Peaceful ocean waves during golden hour. The rhythmic sound of waves creates a calming atmosphere.',
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(2),
          child: const Text('Next Photo'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(0),
          child: const Text('Previous'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createGalleryPage3() {
    return AppWoltModalPage.standard(
      id: 'gallery3',
      title: 'City Lights',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.purple[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.location_city,
              size: 64,
              color: Colors.purple,
            ),
          ),
          AppSpacing.md.gapV,
          const Text(
            'Vibrant city skyline at night with glowing lights. The urban landscape comes alive after dark.',
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: _safePopModal,
          child: const Text('Done'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Previous'),
        ),
      ),
    );
  }

  // Complex Form Pages
  WoltModalSheetPage _createComplexFormPage1() {
    return AppWoltModalPage.form(
      id: 'form1',
      title: 'Personal Information',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'First Name',
              border: OutlineInputBorder(),
            ),
          ),
          AppSpacing.md.gapV,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Last Name',
              border: OutlineInputBorder(),
            ),
          ),
          AppSpacing.md.gapV,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Date of Birth',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
          ),
        ],
      ),
      primaryAction: AppButton.primary(
        onPressed: () => _safeSetPageIndex(1),
        child: const Text('Continue'),
      ),
      secondaryAction: AppButton.secondary(
        onPressed: _safePopModal,
        child: const Text('Cancel'),
      ),
    );
  }

  WoltModalSheetPage _createComplexFormPage2() {
    return AppWoltModalPage.form(
      id: 'form2',
      title: 'Contact Details',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
          ),
          AppSpacing.md.gapV,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          AppSpacing.md.gapV,
          const TextField(
            decoration: InputDecoration(
              labelText: 'Address',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.location_on),
            ),
            maxLines: 2,
          ),
        ],
      ),
      primaryAction: AppButton.primary(
        onPressed: () => _safeSetPageIndex(2),
        child: const Text('Continue'),
      ),
      secondaryAction: AppButton.secondary(
        onPressed: () => _safeSetPageIndex(0),
        child: const Text('Back'),
      ),
    );
  }

  WoltModalSheetPage _createComplexFormPage3() {
    return AppWoltModalPage.standard(
      id: 'form3',
      title: 'Preferences',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Country',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'us', child: Text('United States')),
              DropdownMenuItem(value: 'ca', child: Text('Canada')),
              DropdownMenuItem(value: 'uk', child: Text('United Kingdom')),
            ],
            onChanged: (value) {},
          ),
          AppSpacing.md.gapV,
          CheckboxListTile(
            title: const Text('Email notifications'),
            value: true,
            onChanged: (value) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),
          CheckboxListTile(
            title: const Text('SMS notifications'),
            value: false,
            onChanged: (value) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: () => _safeSetPageIndex(3),
          child: const Text('Continue'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(1),
          child: const Text('Back'),
        ),
      ),
    );
  }

  WoltModalSheetPage _createComplexFormPage4() {
    return AppWoltModalPage.standard(
      id: 'form4',
      title: 'Review & Submit',
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Please review your information:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text('Name: John Doe'),
          Text('Email: john.doe@example.com'),
          Text('Phone: +1 234 567 8900'),
          Text('Country: United States'),
          SizedBox(height: 16),
          Text('Notifications: Email only'),
        ],
      ),
      actions: AppWoltModalPageActions(
        primary: AppButton.primary(
          onPressed: _safePopModal,
          child: const Text('Submit'),
        ),
        secondary: AppButton.secondary(
          onPressed: () => _safeSetPageIndex(2),
          child: const Text('Back'),
        ),
      ),
    );
  }
}
