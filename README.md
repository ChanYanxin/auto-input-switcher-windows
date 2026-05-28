# auto-input-switcher-windows
An elegant, event-driven Windows input method (IME) automatic switcher powered by AutoHotkey (AHK). This script optimizes your human-machine interface by automatically toggling your input language based on the active window state, eliminating manual switching layout dead-zones.
## Core Principle (How it Works)
This solution functions as a software-based **Programmable Logic Controller (PLC)**. 
1. **Input (Sensor):** The AHK engine samples the operating system's active window state at a high frequency (every 200ms).
2. **Logic (Controller):** The `.ahk` script processes the active process name against user-defined state transition rules.
3. **Output (Actuator):** When a state change is validated, the script calls the Windows API via `PostMessage` to inject the target Language ID (HKL), seamlessly altering the IME status.

---

## Installation & Quick Start

### Step 1: Install AutoHotkey Engine
1. Download and install **AutoHotkey v1.1 (Deprecating but highly stable for API posting)** or **v2** from the [Official AutoHotkey Website](https://www.autohotkey.com/).
2. Follow the standard installation prompts. The engine acts as the runtime environment for your scripts.

### Step 2: Clone or Download this Repository
Clone this repository to your local machine:
Code output
Files successfully generated.
git clone [https://github.com/YOUR_USERNAME/Auto-Input-Switcher.git](https://github.com/YOUR_USERNAME/Auto-Input-Switcher.git)
Alternatively, download the ZIP archive and extract it.

### Step 3: Run the Script
Double-click input_switcher.ahk. A green icon with an "H" will appear in your Windows system tray (bottom-right corner), indicating the background listener is active.

## How to Customize Your Rules
You can open input_switcher.ahk with any text editor (VS Code, IntelliJ, Notepad++) to modify the rules. The script uses a highly intuitive IF-THEN State Machine structure.

### 1. Finding Your Software's Process Name
To find the precise process name of an application:

Open the application (e.g., IntelliJ IDEA).

Press Ctrl + Shift + Esc to open the Windows Task Manager.

Go to the Details tab and look for the .exe filename (e.g., idea64.exe, Code.exe, chrome.exe).

### 2. Modifying the State Transition Logic
Locate the 【State Transition Rules】 section in the script and alter the application names inside the conditions:

AutoHotkey


; === [Example Modification] ===
if (ActiveProcess = "idea64.exe" or ActiveProcess = "Code.exe" or ActiveProcess = "clion64.exe")
{
    ; Force switch to English when coding environments are focused
    SwitchToEnglish()
}
else if (ActiveProcess = "chrome.exe" or ActiveProcess = "WeChat.exe" or ActiveProcess = "Teams.exe")
{
    ; Switch back to your native language for documentation/communication
    SwitchToChinese()
}
### 3. Adjusting Language IDs (Locale Identifiers)
The script communicates directly with Windows using hex codes. If you use custom layouts, update the language tokens at the bottom of the script:

#### 0x4090409: United States English (Default for Coding)

#### 0x8040804: Chinese (Simplified, PRC Standard)

#### 0x4070407: German (Standard Germany Layout)

To swap an action to German, simply change the function call or substitute the ID:
(AutoHotkey)
SwitchToGerman() {
    PostMessage, 0x50, 0, 0x4070407,, A  ; Switches layout to German
}


## Repository Structure
input_switcher.ahk - The main executable production script.
README.md - Technical overview and user guide.
