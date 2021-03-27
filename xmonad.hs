import XMonad
import XMonad.Config.Desktop (desktopConfig)
import XMonad.Util.EZConfig (additionalKeys)
-- import XMonad.Layout (Full)
import XMonad.Layout.ThreeColumns (ThreeCol(ThreeColMid))
-- import XMonad.Layout.DragPane (DragPane, dragPane, DragType(Vertical))
import XMonad.Layout.ResizableTile (ResizableTall(..))
-- import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Actions.GridSelect (goToSelected)
import Graphics.X11.ExtraTypes.XF86 (xF86XK_Sleep)
import qualified XMonad.StackSet as W

main =
   xmonad $ desktopConfig
    { borderWidth        = 3
    , terminal           = "qterminal"
    , modMask = mod4Mask
    , normalBorderColor  = "#000000"
    , focusedBorderColor = "#0000ff"
    , layoutHook = myLayouts
    -- , startupHook = setWMName "LG3D" -- for some Java apps, like SQuirreL
    } `additionalKeys` myKeys

myLayouts =
  -- ResizableTall layout has a large master window on the left,
  -- and remaining windows tile on the right.
  -- Parameters are:
  -- 1. The default number of windows in the master pane
  -- 2. Percent of screen to increment by when resizing panes
  -- 3. Default proportion of screen occupied by master pane
  ResizableTall 1 (3/100) (1/2) []
  -- ThreeColMid layout puts the large master window in the center
  -- of the screen.
  -- Parameters are:
  -- 1. The default number of windows in the master pane
  -- 2. Percent of screen to increment by when resizing panes
  -- 3. Default proportion of screen occupied by master pane
  ||| ThreeColMid 1 (3/100) (1/2)
  -- Full layout makes every window full screen. When you toggle the
  -- active window, it will bring the active window to the front.
  ||| Full

myKeys =
  -- Move focus to the next window
  [ ((mod1Mask,               xK_Tab         ), windows W.focusDown)
  , ((mod4Mask,               xK_Right       ), windows W.focusDown)
  -- Move focus to the previous window
  , ((mod1Mask .|. shiftMask, xK_Tab         ), windows W.focusUp)
  , ((mod4Mask,               xK_Left        ), windows W.focusUp)
  -- Open the GridSelect menu
  , ((mod4Mask,               xK_Up          ), goToSelected def)
  -- Copy text with a reference to the source
  , ((mod4Mask,               xK_c           ), spawn "copyWithRef")
  -- Display status bar
  , ((mod4Mask,               xK_d           ), spawn "date | dzen2 -fg green -bg black -p 5 -xs 1")
  -- Open snippet application
  , ((mod4Mask,               xK_s           ), spawn "snippy")
--   , ((mod4Mask .|. shiftMask, xK_m        ), spawn "echo Delay 1 > .macro_0; xmacrorec2 -k 9 | grep -v Super_L >> .macro_0")
--   , ((mod4Mask,               xK_m        ), spawn "xmacroplay -d 10 :0 < .macro_0")
  -- Display key bindings. Mnemonic: Shift + '/' is '?'
  , ((mod4Mask .|. shiftMask, xK_slash       ), spawn "sxiv ~/github/eolas/Xmbindings.png")
  -- Lock the screen
  , ((mod4Mask,               xK_Scroll_Lock ), spawn "xscreensaver-command --lock")
  , ((0,                      xF86XK_Sleep   ), spawn "xscreensaver-command --lock")
  , ((0,                      xK_Pause       ), spawn "xscreensaver-command --lock")
  -- Shrink the master area
  , ((mod4Mask .|. shiftMask, xK_Left        ), sendMessage Shrink)
  -- Expand the master area
  , ((mod4Mask .|. shiftMask, xK_Right       ), sendMessage Expand)
  ]
