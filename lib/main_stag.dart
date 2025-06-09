import 'package:codika_template_empty_no_splash_screen/flavors.dart';
import 'main.dart';

// * Entry point for the stag flavor
void main() async {
  // Add environnement dependent code here
  // ...
  
  F.appFlavor = Flavor.stag;
  await runMainApp();
}
