package com.example.flutter_trip;

import android.os.Bundle;

import com.example.asr_plugin.AsrPlugin;
import org.devio.flutter.splashscreen.SplashScreen;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;
public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    SplashScreen.show(this, true);// here
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    registerSelfPlugin();
  }
  private void registerSelfPlugin(){
    AsrPlugin.registerWith(registrarFor("com.example.asr_plugin.AsrPlugin"));
  }
}
