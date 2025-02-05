# MagiClaw App

[![Swift](https://img.shields.io/badge/Swift-5.7-orange.svg)](https://swift.org) ![iOS](https://img.shields.io/badge/iOS-17.0%2B-blue.svg) 

A SwiftUI-based iOS application designed for collecting various types of data using ARKit and external sensors. This app allows for recording RGB video, LiDAR depth data, and 4x4 transform matrices from the iPhone's sensor. Additionally, it interfaces with a Raspberry Pi via WebSocket to capture many other types data in real-time.

## Features

- **RGB Video Recording**: Capture RGB videos from the iPhone's rear camera.
- **LiDAR Depth Data**: Record depth data using the iPhone's LiDAR sensor, if available. Depth frames are saved in `.bin` format.
- **Transform Matrix Collection**: Store 4x4 homogeneous transform matrices that represent the device's pose during recording.
- **WebSocket Integration**: Connect to a Raspberry Pi on the same local network to receive and record force and angle data from external sensors.
- **Data Export**: Save all collected data to the iOS "Files" app upon stopping the recording, including:
  - `AngleData.csv`: Captures angle data received from the Raspberry Pi.
  - `ForceData.csv`: Captures force data received from the Raspberry Pi.
  - `PoseData.csv`: Stores the transform matrices collected from the iPhone.
  - `yyyyMMdd_HHmmss_RGB.mp4`: A video file of the recorded RGB frames.
  - `yyyyMMdd_HHmmss_Depth/`: A directory containing depth data frames in `.bin` format.

## Usage

1. **Start Recording**:
   - Launch the app on your iPhone.
   - Ensure the Raspberry Pi is online and transmitting data.
   - Press the "Start Recording" button in the app to begin capturing data.

2. **Stop Recording**:
   - Press the button to end the session.
   - The app will automatically save all recorded data to the "Files" app in a dedicated folder.

3. **Access Recorded Data**:
   - Open the "Files" app on your iPhone.
   - Navigate to the app's folder to find the CSV files (`AngleData.csv`, `ForceData.csv`, `PoseData.csv`), the RGB video (`yyyyMMdd_HHmmss_RGB.mp4`), and the depth data (`yyyyMMdd_HHmmss_Depth/` folder).

## Requirements

- iOS 17.0 or later
- An iPhone with a LiDAR sensor (for depth data recording)
- A configured Raspberry Pi with WebSocket capability
- Xcode 15.0 or later

## Contact

For any inquiries or issues, please contact [mr.wutianyu@gmail.com](mailto:mr.wutianyu@gmail.com).

