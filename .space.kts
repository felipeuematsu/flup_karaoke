/**
* JetBrains Space Automation
* This Kotlin script file lets you automate build activities
* For more info, see https://www.jetbrains.com/help/space/automation.html
*/

job("Build, run tests, and publish") {
    container(displayName = "Run script", image = "dart:stable") {
        shellScript {
            content = """
 				flutter analyze --no-fatal-warnings --no-fatal-infos
                
                echo Authorize in Space Packages...
                dart pub token add https://dart.pkg.jetbrains.space/flup/p/main/flup --env-var JB_SPACE_CLIENT_TOKEN
                echo Start publishing...
                dart pub publish -f
            """
        }
    }
}