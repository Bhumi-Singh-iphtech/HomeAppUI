# Home App UI

## Introduction
A simple and elegant Home App interface built using Swift and Xcode, demonstrating:

** Dashboard Screen ** :
Shows tabs for rooms (Living Room, Kitchen, Bedroom), scene buttons (Awakening, Night, Calm, Energetic), and a device list (Air Conditioner, Smart Light, Smart TV)
** Room Devices Screen **:
Displays room image and connected devices with control buttons 
** Device Control Screen **:
Detailed AC control panel with temperature dial, modes (Hot, Cold, Dry Air, Humid), and scheduling options

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
- Contributions are welcome!  
- If you find any issues or have any suggestions for improvement, please submit an issue or create a pull request.
---
## Support
- If you encounter any problems or have any questions, please contact the project maintainer at [email protected].
---

## Acknowledgements
We would like to thank the Apple community for their excellent framework and documentation, which greatly facilitated the development of this project.

---
## Screenshots
<div style="display: flex; gap: 10px;">

  <img src="Screenshots/First Screen.png" width="200">
  <img src="Screenshots/Second Screen.png" width="200">
  <img src="Screenshots/Third Screen.png" width="200">

</div>

![App Demo](Screenshots/Simulator%20Screen%20Recording%20-%20iPhone%2014%20-%202025-09-15%20at%2016.39.14.gif)
 


