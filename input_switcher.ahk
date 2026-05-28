; ==========================================
; 全局配置：每当窗口发生切换时，触发以下逻辑
; ==========================================

#Persistent ; 让脚本持续在后台运行
SetTimer, WatchActiveWindow, 200 ; 每 200 毫秒检测一次当前活跃窗口

WatchActiveWindow:
    ; 1. 获取当前活动窗口的进程名称（例如 idea64.exe, chrome.exe）
    WinGet, ActiveProcess, ProcessName, A
    
    ; 2. 防止在同一个窗口内重复触发，记录上一次的窗口
    if (ActiveProcess = LastProcess)
        return
    LastProcess := ActiveProcess

    ; 3. 【核心逻辑：状态转移方程】
    if (ActiveProcess = "idea64.exe" or ActiveProcess = "Code.exe")
    {
        ; 如果切换到了 IntelliJ 或 VS Code -> 强制切为英文
        SwitchToEnglish()
    }
    else if (ActiveProcess = "chrome.exe" or ActiveProcess = "WeChat.exe")
    {
        ; 如果切换到了浏览器或微信 -> 可以选择切换到中文
        SwitchToChinese()
    }
return

; ==========================================
; 底层控制函数：调用 Windows API 切换输入法
; ==========================================
SwitchToEnglish() {
    ; WM_INPUTLANGCHANGEREQUEST = 0x50
    ; 0x4090409 是美式英文的语言 ID
    PostMessage, 0x50, 0, 0x4090409,, A
}

SwitchToChinese() {
    ; 0x8040804 是中文（中国）的语言 ID
    PostMessage, 0x50, 0, 0x8040804,, A
}