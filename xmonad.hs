--
-- Xmonad config file.
--
--
-- Imports

-- Base
import XMonad.Core
import XMonad
import Data.Monoid
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- Actions
import XMonad.Actions.Search
import XMonad.Actions.NoBorders
import XMonad.Actions.SpawnOn 

-- Hooks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicBars
-- Layout
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Spiral
import XMonad.Layout.WindowArranger

-- Manage
import XMonad.ManageHook

--System
import System.IO

-- Util
import XMonad.Util.SpawnOnce
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)


-- My preferred terminal program.
--
myTerminal      = "konsole"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
--
xmobarEscape :: String -> String
xmobarEscape = concatMap doubleLts
    where
        doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . map xmobarEscape
               $ ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    where
        clickable l = [ "<action=xdotool key super+" ++ show n ++ ">" ++ ws ++ "</action>" |
                      (i,ws) <- zip [1..9] l,
                      let n = i ]

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

-- Border colors for unfocused and focused windows.
--
myNormalBorderColor  = "#000000"
myFocusedBorderColor = "#ffffff"

------------------------------------------------------------------------
-- Key bindings.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return ), spawn $ XMonad.terminal conf)

    -- launch rofi

    , ((modm .|. shiftMask, xK_Return), spawn "rofi -show drun")

    -- launch brave
    , ((modm .|. shiftMask, xK_f     ), spawn "firefox")

    -- launch file manager
    , ((modm,               xK_f     ), spawn "thunar .")
   
    -- launch file manager
    , ((modm,               xK_d     ), spawn "Thunar Desktop")
  
     
    -- launch telegram
    , ((modm .|. shiftMask, xK_t     ), spawn "telegram-desktop")

    -- launch NES EMULATOR Fceux 
    , ((modm .|. shiftMask, xK_p     ), spawn "fceux")

        -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_s     ), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))
    
    , ((modm              , xK_g     ),   withFocused toggleBorder)

   --LAPTOP upper row (lenovo, check with xorg-xev(AUR))
    , ((0                     , 0x1008FF11), spawn "amixer set Master 2-")
    , ((0                     , 0x1008FF13), spawn "amixer set Master 2+")
       
    -- Resize Windowa
    , ((modm .|. controlMask              , xK_s    ), sendMessage  Arrange         )
    , ((modm .|. controlMask .|. shiftMask, xK_s    ), sendMessage  DeArrange       )
    , ((modm .|. controlMask              , xK_Left ), sendMessage (MoveLeft      5))
    , ((modm .|. controlMask              , xK_Right), sendMessage (MoveRight     5))
    , ((modm .|. controlMask              , xK_Down ), sendMessage (MoveDown      5))
    , ((modm .|. controlMask              , xK_Up   ), sendMessage (MoveUp        5))
    , ((modm                 .|. shiftMask, xK_Left ), sendMessage (IncreaseLeft  5))
    , ((modm                 .|. shiftMask, xK_Right), sendMessage (IncreaseRight 5))
    , ((modm                 .|. shiftMask, xK_Down ), sendMessage (IncreaseDown  5))
    , ((modm                 .|. shiftMask, xK_Up   ), sendMessage (IncreaseUp    5))
    , ((modm .|. controlMask .|. shiftMask, xK_Left ), sendMessage (DecreaseLeft  5))
    , ((modm .|. controlMask .|. shiftMask, xK_Right), sendMessage (DecreaseRight 5))
    , ((modm .|. controlMask .|. shiftMask, xK_Down ), sendMessage (DecreaseDown  5))
    , ((modm .|. controlMask .|. shiftMask, xK_Up   ), sendMessage (DecreaseUp    5))


   
    -- Screen Spacing 
    , ((modm .|. controlMask              , xK_n    ), decScreenSpacing 5        )
    , ((modm .|. controlMask .|. shiftMask, xK_n    ), incScreenSpacing 5        )
       

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:
--
-- The available layouts. Each layout is separated by |||.
--
myLayout = avoidStruts $ spacingRaw True (Border 10 10 20 10) True (Border 10 10 10 20) True (tiled ||| spiral (6/7) ||| ThreeColMid 1 (3/100) (1/2) ||| Grid  ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore
    
    ]
------------------------------------------------------------------------
-- Event handling
--
myEventHook = mempty
------------------------------------------------------------------------
-- Startup hook

myStartupHook = do    
    spawnOnce "picom &"
    spawnOnce "nitrogen --restore &" 
    spawnOnce "setxkbmap hr &"
    spawnOnce "source ~/.bash_aliases &"
-------------------------------------------------------------------------
-- Run xmonad with the settings specified.
--
main = do
   xmproc0 <- spawnPipe "xmobar -x 0 /home/$USER/.config/.xmobar/xmobarrc0"

   xmonad $ docks def {


      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = windowArrange myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = dynamicLogWithPP xmobarPP
                               { ppOutput = hPutStrLn xmproc0 

                               , ppCurrent = xmobarColor "#0076ff" "" . wrap "[ " " ]" -- Current workspace in xmobar
                               , ppVisible = xmobarColor "#04d9ff" ""                  -- Visible but not current workspace
                               , ppHidden = xmobarColor "#04d9ff" "" . wrap "*" ""     -- Hidden workspaces in xmobar
                               , ppHiddenNoWindows = xmobarColor "#04d9ff" ""          -- Hidden workspaces (no windows)
                               , ppTitle = xmobarColor  "#04d9ff" "" . wrap " <icon=folder.xpm/> " ""        -- Title of active window in xmobar
                               , ppSep =  "<fc=#ffffff> | </fc>"                       -- Separators in xmobar
                               , ppUrgent = xmobarColor "#D58546" "" . wrap "!" "!"    -- Urgent workspace
   
                               , ppOrder = \(ws:_:_:_) -> [ws]
                               },
        startupHook        = myStartupHook
      }
