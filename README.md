# Home App UI

## Introduction
A simple and elegant Home App interface built using Swift and Xcode, demonstrating:

- Navigation between multiple screens
- Collection views for tabs, scenes, and devices
- A custom gradient background
- A toggle button with callback functionality

---

## Features

### Gradient Background
- Custom `GradientView` subclass using `CAGradientLayer`.

### Tabs Collection View (Rooms)
- Horizontally scrolling list of rooms (Living Room, Kitchen, Bedroom, etc.)
- Selecting a room navigates to `SecondScreenViewController`.

### Scenes Collection View
- Shows preset scene modes: Awakening, Night, Calm, Energetic
- Selecting a scene updates its background color to highlight selection.

### Devices Collection View
- Shows smart home devices like Air Conditioner, Smart Light, Smart TV
- Selecting a device highlights it and navigates to a detail screen.

### Main Toggle Button
- Custom Toogle class controls a UI toggle (On/Off)
- Includes a callback closure to handle toggle state changes.

### Navigation
- Navigation controller used for pushing second and third screens

---

## Prerequisites
- Xcode 12.0 or later
- iOS 14.0 or later
- Swift 5.0 or later

---

## License
This project is open source.  


---

## Contributing
Contributions are welcome!  
If you find any issues or have suggestions for improvement, please:

- Submit an issue
- Or create a pull request

---



