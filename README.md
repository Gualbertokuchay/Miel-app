
Iconos--
https://www.flaticon.es/resultados?word=abeja

Paquetes utilizados:
Cambia el icono de tu app /miel/android/app/src/main/res/mipmap-hdpi

la imagen con tu logo o icono le cambiar el nombre por ic_launcher.png y lo plasas solo a las 5 imagenes que esta en diferentes partes

en este link los puedes descarga e instalar 

https://pub.dev/ 

  provider: ^6.1.1
  flutter_svg: ^2.0.9
  animate_do: ^3.1.2
  video_player: ^2.8.1
  chewie: ^1.7.4
  flutter_spinkit: ^5.2.0
  fluttertoast: ^8.2.4

  Version de flutter   sdk: '>=3.2.3 <4.0.0' 

Apatacion a conexiones android/app/build.gradle 

configuracion del gradle

defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId "com.example.miel"
        // You can update the following values to match your application needs.
        // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
        multiDexEnabled true
        minSdkVersion 21
        targetSdkVersion 33
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source '../..'
}

dependencies {
    implementation 'com.android.support:multidex:1.0.3'
}


configuracion de iconos y imagenes(SVG)
# To add assets to your application, add an assets section, like this:
  assets:
      - assets/
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware


  


Verifica los datos de el carrito falto- realizar la suma de los articulos 
