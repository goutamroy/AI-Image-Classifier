# 🚀 AI Image Classifier iOS App

## 📱 Overview

AI Image Classifier is a modern iOS application built using **SwiftUI, CoreML, and Vision Framework**.

The app demonstrates **on-device AI capabilities**, allowing users to:

* Classify images using a pre-trained ML model
* Convert speech to text using voice input
* Explore real-time camera-based scanning (device only)

---

## ✨ Features

### 🖼️ Image Classification

* Select image from photo library
* Classify using **MobileNetV2 CoreML model**
* Displays **Top 3 predictions with confidence scores**
* Clean and user-friendly UI with progress indicators

---

### 🎤 Voice Assistant

* Real-time **speech-to-text conversion**
* Start / Stop listening toggle
* Built using **Apple Speech Framework + AVAudioEngine**
* Demonstrates live audio streaming and recognition

---

### 📷 Live Camera Scanner

* Real-time camera preview using AVFoundation
* Ready for future **real-time ML integration**
* Works only on **physical device** (not simulator)

---

## 🏗️ Architecture

This project follows **MVVM (Model-View-ViewModel)** architecture for clean separation of concerns.

### 🔹 Layers

#### 1. View (UI Layer)

* Built using SwiftUI
* Handles user interaction and rendering

**Examples:**

* `ContentView`
* `ImageRecognitionView`
* `VoiceView`
* `CameraView`

---

#### 2. ViewModel (Business Logic)

* Manages app state using `@Published`
* Handles interaction between View and Services

**Examples:**

* `ImageRecognitionViewModel`
* `VoiceViewModel`
* `CameraViewModel`

---

#### 3. Services (Core Logic)

* Encapsulates external frameworks and logic

**Examples:**

* `CoreMLService` → Image classification
* `SpeechService` → Speech recognition
* `CameraService` → Camera handling

---

#### 4. Model (Data Layer)

* Represents structured data

**Example:**

* `PredictionResult`

---

## 🧠 Tech Stack

* **SwiftUI**
* **CoreML (MobileNetV2)**
* **Vision Framework**
* **AVFoundation**
* **Speech Framework**
* **Combine**

---

## ⚙️ How It Works

### 🔍 Image Classification Flow

```
User selects image
→ View triggers ViewModel
→ ViewModel calls CoreMLService
→ Vision processes image
→ CoreML model predicts labels
→ Results displayed in UI
```

---

### 🎤 Voice Recognition Flow

```
User taps Start Listening
→ AVAudioEngine captures audio
→ SpeechService processes audio buffers
→ SFSpeechRecognizer converts speech to text
→ UI updates in real-time
```

---

## 🔐 Permissions Required

Add the following keys in `Info.plist`:

* `NSCameraUsageDescription`
* `NSPhotoLibraryUsageDescription`
* `NSMicrophoneUsageDescription`
* `NSSpeechRecognitionUsageDescription`

---

## 📦 Installation & Setup

1. Clone the repository:

```
git clone https://github.com/YOUR_USERNAME/AI-Image-Classifier.git
```

2. Open in Xcode:

```
open AI-Image-Classifier.xcodeproj
```

3. Run on:

* Simulator (limited features)
* **Real device (recommended)**

---

## 📸 Screenshots



Example:

```
/Screenshots/home.png
/Screenshots/classification.png
/Screenshots/voice.png
```

---

## ⚠️ Notes

* Camera is **not available in Simulator**
* Speech recognition may be limited in Simulator
* Best experience on **real iPhone device**

---

## 📈 Future Improvements

* Real-time object detection (Vision + CoreML)
* Voice command → trigger actions (e.g., "Analyze Image")
* Save scan history using SwiftData
* Model optimization for performance
* Offline caching and improvements

---

## 👨‍💻 Author

**Goutam Roy**
Senior iOS Developer | AI/ML Enthusiast

---

