# ZealTimer

**ZealTimer** is a World of Warcraft addon designed to help players monitor their *Zeal* buff in real time. It provides a draggable, transparent frame that displays the remaining time and stack count of your *Zeal* buff, allowing for quick and easy tracking during gameplay.

## Features
- **Movable Frame**: Hold `CTRL + Left-Click` to drag the frame to any position on your screen.
- **Buff Tracking**: Automatically updates whenever the *Zeal* buff is active, displaying stack count and remaining time.
- **Visual Display**: Shows "Zeal:" along with the buff duration and stack count. If inactive, the timer shows "N/A."
- **Countdown Timer**: Tracks the *Zeal* buff's 30-second countdown, so you always know how much time remains.
- **Accurate Buff Detection**: Matches the *Zeal* icon texture to ensure precise tracking of the buff.

## How It Works
1. **Frame Setup**: Displays a 100x90 frame in the center of the screen, offset 145 pixels to the right, with a semi-transparent black background.
2. **Event-Driven Updates**: Listens for specific in-game events to update the buff status:
   - `UNIT_AURA`: Updates when buffs are gained or lost.
   - `PLAYER_ENTERING_WORLD`: Initializes tracking when you log in.
   - `CHAT_MSG_SPELL_SELF_DAMAGE`: Detects *Crusader Strike* to start or reset the buff timer.
3. **Dynamic Timer Display**: Updates the timer display every second to show the current countdown and stack count. When *Zeal* is not active, the display shows "N/A" and zero stacks.

## Usage
1. Install ZealTimer (instructions below).
2. Start World of Warcraft, and ZealTimer will load automatically.
3. Use `CTRL + Left-Click` to drag the frame to your preferred location on the screen.
4. The display will automatically update to show:
   - **Remaining Time**: Counts down from 30 seconds when *Zeal* is active.
   - **Stack Count**: Shows the current stack count of *Zeal*.

## Installation
1. Download the addon files.
2. Place them in your `World of Warcraft/Interface/AddOns` folder.
3. Restart World of Warcraft.

Enjoy enhanced buff tracking with **ZealTimer**!

---

Developed by **Dollerp**
