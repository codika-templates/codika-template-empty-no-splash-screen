import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "io.codika.codika_template_empty_no_splash_screen.dev"
            resValue(type = "string", name = "app_name", value = "Codika Template Empty No Splash Screen Dev")
        }
        create("stag") {
            dimension = "flavor-type"
            applicationId = "io.codika.codika_template_empty_no_splash_screen.stag"
            resValue(type = "string", name = "app_name", value = "Codika Template Empty No Splash Screen Stag")
        }
        create("prod") {
            dimension = "flavor-type"
            applicationId = "io.codika.codika_template_empty_no_splash_screen"
            resValue(type = "string", name = "app_name", value = "Codika Template Empty No Splash Screen")
        }
    }
}