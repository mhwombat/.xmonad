import           XMonad
import           XMonad.Config.Desktop        (desktopConfig)
import           XMonad.Util.EZConfig         (additionalKeysP)
-- import XMonad.Layout (Full)
import           XMonad.Layout.ThreeColumns   (ThreeCol (ThreeColMid))
-- import XMonad.Layout.DragPane (DragPane, dragPane, DragType(Vertical))
import           XMonad.Layout.ResizableTile  (ResizableTall (..))
-- import XMonad.Hooks.SetWMName (setWMName)
import           Graphics.X11.ExtraTypes.XF86 (xF86XK_Sleep)
import           XMonad.Actions.GridSelect    (goToSelected)
import qualified XMonad.StackSet              as W

main =
   xmonad $ desktopConfig
    { borderWidth        = 3
    , terminal           = "kitty"
    , modMask = mod4Mask
    , normalBorderColor  = "#000000"
    , focusedBorderColor = "#0000ff"
    , layoutHook = myLayouts
    } `additionalKeysP` myKeys

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
  [ ("M-<Tab>", windows W.focusDown)
  , ("M4-<Right>", windows W.focusDown)
  -- Move focus to the previous window
  , ("M-S-<Tab>", windows W.focusUp)
  , ("M4-<Left>", windows W.focusUp)
  -- Open the GridSelect menu
  , ("M4-<Up>", goToSelected def)
  -- Copy text with a reference to the source
  , ("M4-c", spawn "copyWithRef")
  -- Display status bar
  , ("M4-d", spawn "date | dzen2 -fg green -bg black -p 5 -xs 1")
  -- Open snippet application
  , ("M4-s", spawn "snippy")
  --   , ("M4-S-m", spawn "echo Delay 1 > .macro_0; xmacrorec2 -k 9 | grep -v Super_L >> .macro_0")
  --   , ("M4-m", spawn "xmacroplay -d 10 :0 < .macro_0")
  -- Display key bindings. Mnemonic: Shift + '/' is '?'
  , ("M4-S-/", spawn "sxiv ~/github/eolas/Xmbindings.png")
  -- Lock the screen
  , ("M4-<Scroll_Lock>", spawn "xscreensaver-command --lock")
  , ("<F86XK_Sleep>", spawn "xscreensaver-command --lock")
  , ("<Pause>", spawn "xscreensaver-command --lock")
  -- Shrink the master area
  , ("M4-S-<Left>", sendMessage Shrink)
  -- Expand the master area
  , ("M4-S-<Right>", sendMessage Expand)
  ]
