# ZealTimer

**ZealTimer** is a World of Warcraft addon that helps you keep track of your *Zeal* buff in real-time. This addon provides a draggable, semi-transparent frame that shows your current *Zeal* buff stacks and remaining time, making it easy to monitor during gameplay.

## Features
- **Movable Frame**: Drag the frame to any position on your screen by holding the left mouse button.
- **Real-Time Buff Tracking**: Automatically updates when *Zeal* stacks change.
- **Visual Display**: Shows the "Zeal:" label with the current stack count and remaining time.
- **30-Second Countdown**: Displays time remaining for the *Zeal* buff before it expires.
- **Icon Matching**: Detects the *Zeal* buff by matching the known icon texture.

## How It Works
1. **Frame Setup**: Creates a 100x90 frame at the center of the screen, offset 145 pixels to the right. The frame has a semi-transparent black background with padding for readability.
2. **Event-Driven Updates**: The frame listens for key in-game events to update the display:
   - `UNIT_AURA`: Updates when you gain or lose buffs.
   - `PLAYER_ENTERING_WORLD`: Ensures tracking begins when you log in.
   - `CHAT_MSG_SPELL_SELF_DAMAGE`: Activates when you use *Crusader Strike*.
3. **Dynamic Display**: The timer display updates every second. When *Zeal* is inactive, it shows "N/A."

## Usage
Once installed, ZealTimer will automatically load and start tracking your *Zeal* buff. The display shows:
- **Remaining Time**: Updates continuously to show time left on the *Zeal* buff.
- **Stack Count**: Displays the current stack count of *Zeal*.

Simply keep an eye on the ZealTimer frame to monitor your buff status and maximize its potential!

## Installation
1. Download the addon files.
2. Place them in your `World of Warcraft/_retail_/Interface/AddOns` folder.
3. Restart World of Warcraft.

Happy buff tracking with **ZealTimer**!

---

Created by **Dollerp**
