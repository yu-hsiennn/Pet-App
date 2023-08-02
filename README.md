<html>
<body>
<div class="image-container">
  <img src="https://hackmd.io/_uploads/rJdV4WWs2.png" width="400" height="400">
</div>
</body>
</html>

## About
A flutter application to let pet owners find each other more easily. The app's layout is based on fundamental design principles and developed in connection with NCKU's course on collaboration of software engineers and interface designers.

## Features
This app lets you:
- Using Google Maps to find attractions.
- Interacting with different users through posts.
- Using private messaging to contact specific users.
- Create a simple pet profile card for other users to quickly understand pet information.
- Providing pet emotion recognition functionality.(simulation)

## Screenshots
<html>
<body>

<div class="image-container">
  <img src="https://hackmd.io/_uploads/Sy5NWOPoh.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/r1wKW_Dih.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/SJkoXODi2.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/H1xRm_wi3.png" width="200" height="400">
</div>
<div class="image-container">
  <img src="https://hackmd.io/_uploads/rkqM4dPoh.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/BJ-L4_Ps2.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/HyQYNODs3.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/Sk8FE_Pj3.png" width="200" height="400">
</div>
    <div class="image-container">
  <img src="https://hackmd.io/_uploads/S1CaV_Pj2.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/HkmRNOPsh.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/SJFrr_Djh.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/ryhBHdPin.png" width="200" height="400">
</div>
<div class="image-container">
  <img src="https://hackmd.io/_uploads/rJecB_wjh.png" width="200" height="400">
  <img src="https://hackmd.io/_uploads/SJEqHdPj2.png" width="200" height="400">
</div>

</body>
</html>





## Permissions
- **Photos and videos**: Access photos and videos on your device.
- **Microphone**: Record audio.
- **Location**: Access your device's location.

## Authors
- **Designers**:
    - **許慈軒**，**江沛晴**
- **Engineers**:
    - **[Yu-Hsien, Wu](https://github.com/yu-hsiennn)**，**[Felix Weiss](https://github.com/felixweiss1999)**，**[Po-Chun, Huang](https://github.com/Tears8824)**

## Others
- [presentation](https://drive.google.com/file/d/1rywwtDYDMNwhCsWka8_XpKcoRvCOpORd/view?usp=sharing)
---

# Getting started

## Prerequisites
The front-end of this project is developed using **Flutter**, while the back-end interacts through the [Felix Weiss](https://github.com/felixweiss1999)'s pet-app-server [project](https://github.com/felixweiss1999/pet-app-server). As the application will use Google Maps internally, it requires Google Maps API to establish the connection and interact with the maps. Therefore, please make sure you have them available on your machine.
- [Flutter](https://docs.flutter.dev/get-started/install)
- [pet-app-server](https://github.com/felixweiss1999/pet-app-server)
- [How to get a Google Maps API key?](https://developers.google.com/maps/documentation/javascript/overview)
- (option, Android's emulator) [Android Studio](https://developer.android.com/studio)
- (option, IPhone/IPad simulator) [XCode](https://apps.apple.com/tw/app/xcode/id497799835?mt=12)

## Installation
**BEFORE YOU INSTALL**: please read the [Prerequisites](#Prerequisites)

Cloning this repo on your local machine:
```shell
$ git clone https://github.com/yu-hsiennn/Pet-App.git
$ cd Pet-App
```

## Running
**Steps 1.** Set Google Maps API keys
Replace **YOUR KEY HERE** according to the *previously obtained [Google Maps API key](https://developers.google.com/maps/documentation/javascript/get-api-key)*.
- **AndroidManifest.xml** (*Path: Pet-App/android/app/src/main/AndroidManifest.xml*)
```xml=7
        <meta-data android:name="com.google.android.geo.API_KEY"
                android:value="YOUR KEY HERE"/> 
```
- **AppDelegate.swift** (*Path: Pet-App/ios/Runner/AppDelegate.swift*)
```swift=13
        GMSServices.provideAPIKey("YOUR KEY HERE")
```
- **index.html** (*Path: Pet-App/web/index.html*)
```html=29
        <scripts src="https://maps.googleapis.com/maps/api/js?key=YOUR KEY HERE"></scripts>
```
- **location_service.dart** (*Path: Pet-App/lib/location_service.dart*)
```dart=5
        final String key = "YOUR KEY HERE";
```

**Step 2.** Start your [server](https://github.com/felixweiss1999/pet-app-server)
```shell=
# default Server IP: 127.0.0.1:8000
$ uvicorn main:app --reload

# if you want to use your physical iphone/ipad, 
# please make sure that your device and your computer are connected to the same IP.
# And running this command
$ unicorn main:app --host "your IPv4 address" --port 80
```
- You can use a web browser to confirm whether the server has successfully started.(i.e. "your server ip:port/docs#")
    - ex. `Url: 127.0.0.1:8000/docs#`
![](https://hackmd.io/_uploads/Ska9UCEoh.png)


**step 3.** Modify the *Server_Url* variable based on different devices.
- **PetApp.dart** (*Path: Pet-App/lib/PetApp.dart*)

    - Using Android emulator
    ```dart=13
        static String Server_Url = "http://10.0.2.2:8000";
    ```
    
    - Using IPhone/IPad simulator and defalut Server IP address
    ```dart=13
        static String Server_Url = "http://127.0.0.1:8000";
    ```
    
    - Using physical devices
    ```dart=13
        static String Server_Url = "YOUR SERVER IPv4 ADDRESS";
    ```

**step 4.** Running app!
- Using command
    ```shell
    $ flutter run
    ```
- Or run **main.dart** code in VScode/android studio (*Path: Pet-App/lib/main.dart*)

## License
This project is licensed under the MIT. See the LICENSE.md file for details
