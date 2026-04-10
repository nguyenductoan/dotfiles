--This configuration file for Hammerspoon sets up a hotkey to toggle the visibility of an application called "Ghostty". When the F2 key is pressed, it checks if "Ghostty" is the frontmost application. If it is, it hides the application using AppleScript. If it is not, it launches or focuses "Ghostty".
hs.hotkey.bind({}, "F2", function()
  local frontmost = hs.application.frontmostApplication()
  if frontmost and frontmost:name() == "Ghostty" then
    hs.osascript.applescript('tell application "System Events" to set visible of process "Ghostty" to false')
  else
    hs.application.launchOrFocus("Ghostty")
  end
end)
