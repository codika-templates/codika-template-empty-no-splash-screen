# Instructions

When executing flutter commands, ALWAYS prefix with `fvm`. E.g. instead of `flutter pub get` use `fvm flutter pub get`

## Extensions

Use the following extensions when possible:

### BuildContext

Those extensions are defined in `lib/design_system/utils/extensions/build_context.dart`

- Instead of `Theme.of(context).textTheme` use `context.textTheme`
- Instead of `Theme.of(context).colorScheme` use `context.colorScheme`
