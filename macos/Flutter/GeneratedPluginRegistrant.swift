//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import path_provider_foundation
import photo_manager
import shared_preferences_foundation
import speech_to_text_macos
import sqflite

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
  PhotoManagerPlugin.register(with: registry.registrar(forPlugin: "PhotoManagerPlugin"))
  SharedPreferencesPlugin.register(with: registry.registrar(forPlugin: "SharedPreferencesPlugin"))
  SpeechToTextMacosPlugin.register(with: registry.registrar(forPlugin: "SpeechToTextMacosPlugin"))
  SqflitePlugin.register(with: registry.registrar(forPlugin: "SqflitePlugin"))
}
