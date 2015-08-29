/*
  ==============================================================================

    This file was auto-generated by the Introjucer!

    It contains the basic startup code for a Juce application.

  ==============================================================================
*/

#include "../JuceLibraryCode/JuceHeader.h"
#include "MainComponent.h"
//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TestViewController.h"
#import "MainViewController.h"



//==============================================================================
class iosNavigationApplication  : public JUCEApplication
{
public:
    //==============================================================================
    iosNavigationApplication() {}

    const String getApplicationName() override       { return ProjectInfo::projectName; }
    const String getApplicationVersion() override    { return ProjectInfo::versionString; }
    bool moreThanOneInstanceAllowed() override       { return true; }

    //==============================================================================
    void initialise (const String& commandLine) override
    {
        // This method is where you should put your application's initialisation code..

        mainWindow = new MainWindow (getApplicationName());
    }

    void shutdown() override
    {
        // Add your application's shutdown code here..

        mainWindow = nullptr; // (deletes our window)
    }

    //==============================================================================
    void systemRequestedQuit() override
    {
        // This is called when the app is being asked to quit: you can ignore this
        // request and let the app carry on running, or call quit() to allow the app to close.
        quit();
    }

    void anotherInstanceStarted (const String& commandLine) override
    {
        // When another instance of the app is launched while this one is running,
        // this method is invoked, and the commandLine parameter tells you what
        // the other instance's command-line arguments were.
    }

    //==============================================================================
    /*
        This class implements the desktop window that contains an instance of
        our MainContentComponent class.
    */
    class MainWindow    : public DocumentWindow
    {
    public:
        MainWindow (String name)  : DocumentWindow (name,
                                                    Colours::lightgrey,
                                                    DocumentWindow::allButtons)
        {
            setUsingNativeTitleBar (true);
            setContentOwned (new MainContentComponent(), true);

            
            #if JUCE_IOS || JUCE_ANDROID
            setFullScreen (true);
            #else
            setResizable (true, true);
            #endif
            
            centreWithSize (getWidth(), getHeight());
            setVisible (true);
            
            #if JUCE_IOS
            iosWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            iosWindow.backgroundColor = [UIColor grayColor];
            
            MainContentComponent* mainComponent = new MainContentComponent();
            UIView* juceView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
            MainWindow::addComponentToUIView (*mainComponent, juceView);
            MainViewController *viewController = [[MainViewController alloc] initWithContentView: juceView];
            
            [viewController addContentView];
            
            
            navController = [[UINavigationController alloc] initWithRootViewController: viewController];
            [iosWindow setRootViewController:navController];
            
            
            //[iosWindow addSubview: [viewController view]];
            [iosWindow makeKeyAndVisible];
            #endif
            
            
        }

        void closeButtonPressed() override
        {
            // This is called when the user tries to close this window. Here, we'll just
            // ask the app to quit when this happens, but you can change this to do
            // whatever you need.
            JUCEApplication::getInstance()->systemRequestedQuit();
        }
        
        static void addComponentToUIView (Component& comp, UIView* uiView)
        {
            comp.addToDesktop (0, (void*) uiView);
            comp.setVisible (true);
            comp.setBounds (uiView.bounds.origin.x, uiView.bounds.origin.y,
                            uiView.bounds.size.width, uiView.bounds.size.height);
        }

        /* Note: Be careful if you override any DocumentWindow methods - the base
           class uses a lot of them, so by overriding you might break its functionality.
           It's best to do all your work in your content component instead, but if
           you really have to override any DocumentWindow methods, make sure your
           subclass also calls the superclass's method.
        */

    private:
        #if JUCE_IOS
        UIWindow* iosWindow;
        UINavigationController* navController;
        UINavigationBar* navBar;
        #endif
        JUCE_DECLARE_NON_COPYABLE_WITH_LEAK_DETECTOR (MainWindow)
    };

private:
    ScopedPointer<MainWindow> mainWindow;

};

//==============================================================================
// This macro generates the main() routine that launches the app.
START_JUCE_APPLICATION (iosNavigationApplication)
