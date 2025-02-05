# 👋 Welcome to the official documentation of MagiClaw

MagiClaw is a versatile system designed for **universal action embodiment** in robotics, combining multi-modal sensing, teleoperation, and imitation learning capabilities. This documentation covers two key components of the MagiClaw project:

1. **MagiClaw App**: An iOS application for real-time data collection, including RGB video, LiDAR depth, and more.
2. **pymagiclaw API**: A Python-based API for teleoperating the Franka robotic arm and MagiClaw gripper.

---

## MagiClaw App ![iOS](https://img.shields.io/badge/iOS-17.0%2B-blue.svg)

The MagiClaw App is a SwiftUI-based iOS application designed for collecting, recording, and streaming various types of data from iPhone and external sensors.

<p align="center">
  <table>
    <tr>
      <td align="center">
        <img src="https://magiclaw-docs.vercel.app/_next/image?url=%2Fmagiclaw-app.png&w=640&q=75" alt="MagiClaw App" width="200"/>
      </td>
      <td align="center">
        <a href="https://apps.apple.com/us/app/magiclaw/id6661033548?itscg=30200&itsct=apps_box_badge&mttnsubad=6661033548">
          <img 
            src="https://toolbox.marketingtools.apple.com/api/v2/badges/download-on-the-app-store/black/en-us?releaseDate=1726876800" 
            alt="Download on the App Store" 
            width="180" />
        </a>
      </td>
    </tr>
  </table>
</p>

### ✅ System Requirements

- iOS 17 or later.

### 📌 Supported Devices

- iPhone 8 or newer.
- For depth data recording, devices with LiDAR are required (e.g., iPhone 12 Pro or later).

### 🎯 Features

- **RGB Video Recording**: Capture RGB videos from the iPhone's rear camera.
- **LiDAR Depth Data**: Record depth data using the iPhone's LiDAR sensor, if available. Depth frames are saved in `.bin` format.
- **Transform Matrix Collection**: Store 4x4 homogeneous transform matrices that represent the device's pose during recording.
- **WebSocket Integration**: Connect to a Raspberry Pi on the same local network to receive and record force and angle data from external sensors.
- **Data Export**: Save all collected data to the iOS "Files" app upon stopping the recording.

### 💾 Data Recording and Storage

#### Connecting to the Raspberry Pi

1. Ensure both your iPhone and Raspberry Pi are connected to the same Wi-Fi network.
2. Go to the app’s “Settings” page and set your Raspberry Pi’s IP address or hostname.

   - To find your Raspberry Pi's IP address, run `ifconfig` in your Raspberry Pi's terminal.
   - Run `hostname` to find its hostname.

#### Recording Data

1. Navigate to the "Panel" page and tap “Record”.
2. Confirm that the Raspberry Pi connection status is “Connected.”
3. Choose the appropriate task scenario and provide a description.
4. Press “Start recording” to begin capturing data. Press the button again to stop.

#### Viewing and Sharing Data

You can access saved data by navigating to the “MagiClaw” folder in the iPhone’s “Files” app.

#### File Formats

| File Name             | Description                                       |
| --------------------- | ------------------------------------------------- |
| **`metadata.json`**   | Stores metadata of the recorded session.          |
| **`AngleData.csv`**   | Encoder angle values.                             |
| **`R_ForceData.csv`** | 6D force data from the **right** gripper (N, Nm). |
| **`L_ForceData.csv`** | 6D force data from the **left** gripper (N, Nm).  |
| **`PoseData.csv`**    | 6D iPhone pose (4x4 transformation matrix).       |
| **`RGB.mp4`**         | 640×480 rear camera video.                        |
| **`Depth/*.bin`**     | 256×192 depth data, UInt format (10⁻⁴m).          |
| **`Audio.m4a`**       | AAC audio (12kHz, mono).                          |

#### Timestamp

- The first column of each CSV file represents the elapsed time (s).  
- Depth file timestamps are included in filenames.

### 📡 Real-time Data Streaming

#### Starting Data Streaming

1. In the **Panel** tab, select “Remote”.
2. Press **Enable sending data** to start transmitting real-time sensor data via WebSocket. Data includes the iPhone's 6D pose and RGB video.

#### Receiving Data

To receive data from another device, follow these steps:

- Find the iPhone’s IP address in the app’s “Settings” page.
- On the receiving end, create a WebSocket client and connect to: `ws://<IP-address>:8080`.



## 🛠️ `pymagiclaw` API [![Python](https://img.shields.io/badge/Python-3.8%2B-blue.svg)](https://www.python.org/)



The `pymagiclaw` API is a Python library designed to control the Franka Emika robotic arm and the MagiClaw gripper. It provides a simple interface for impedance-based motion control, allowing users to specify absolute or relative positions for the robot's end-effector. Additionally, it supports real-time control of the MagiClaw gripper, enabling precise manipulation tasks.

#### Installation

```bash
pip install pymagiclaw
```

- **Franka Arm Control**: 
  - **Impedance-based Motion**: Control the Franka Emika Panda arm using impedance control for compliant manipulation.
  - **Absolute/Relative Positioning**: Specify target positions in absolute Cartesian coordinates (`x, y, z`) or relative offsets (`Δx, Δy, Δz`).
- **MagClaw Gripper Control**:
  - Open/close the gripper with programmable width.
- **Sensor Integration**: Seamlessly combine robot control with MagiClaw's multi-modal sensing (force, LiDAR, RGB, pose matrix).

