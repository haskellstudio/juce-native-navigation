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

@interface ViewLoader : NSObject 
{
}

@property UINavigationController *navController;

- (void) nextView: (id) sender;

@end



@implementation ViewLoader

- (id) initWithNavigationController: (UINavigationController *) navController {
    self = [super init];
    
    if (self) {
        _navController = navController;
    }
    
    return self;
}


- (void) nextView: (id) sender {
    
    TestViewController *testViewController = [[TestViewController alloc] initWithNibName:@"TestViewController" bundle:nil];
    [_navController pushViewController:testViewController animated:YES];
}

@end


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
            iosWindow.backgroundColor = [UIColor blackColor];
            MainViewController *viewController = [[MainViewController alloc] init];
            navController = [[UINavigationController alloc] initWithRootViewController:viewController];
            [iosWindow setRootViewController:navController];
            [iosWindow makeKeyAndVisible];
            //------------------------------------------------------
            
            UIView* juceView = [[UIView alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
            MainContentComponent* mainComponent = new MainContentComponent();
            mainComponent->addToDesktop (0, juceView);
            viewController.view = juceView;
            [iosWindow addSubview:[navController view]];
            
            navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(juceView.bounds), 32.0)];
            [navBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            [navBar setBarTintColor:[UIColor blackColor]];
            [navBar setTintColor:[UIColor grayColor]];
            //navController.
            NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                                      [UIColor whiteColor],NSForegroundColorAttributeName, nil]; //,
                                                       //                                                               //[UIColor grayColor], UITextAttributeTextShadowColor,
                                                       //                                                               //[NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset, nil];
                                                       //                    
            [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
            
            UINavigationItem *navItem = [[UINavigationItem alloc] init];
            navItem.title = @"Test";
            [navBar setItems:@[navItem]];
            
            #endif
            
//            //UIView* view = (UIView*) getTopLevelComponent()->getWindowHandle();
//            //UIViewController* viewController = view.rootViewController;
//            
//            
//            UIView* view = (UIView*) getTopLevelComponent()->getWindowHandle();
//            UIResponder* viewResponder = view.nextResponder;
//            
//            if ([viewResponder isKindOfClass: [UIViewController class]])
//            {
//                UIViewController* controller = (UIViewController*) viewResponder;
//                //xxx
//                
//                //self.viewController = [[YourViewControllername alloc] initWithNibName:@"YourViewControllername" bundle:nil]
//                
//
//                UIResponder* controllerResponder = ((UIWindow*) controller.nextResponder);
//                
//                DBG ("Got UIViewController");
//                
//                if ([controllerResponder isKindOfClass: [UIWindow class]])
//                {
//                    UIWindow* window = (UIWindow*) controllerResponder;
//                    
//                    window.rootViewController = nil; // <-- prevents error "adding a root view controller <JuceUIViewController> as a child of view controller <UINavigationController>"
//                    navController = [[UINavigationController alloc] initWithRootViewController:controller];
//                    
//                    [window setRootViewController:navController];
//                    [window addSubview:[navController view]];
//                    [window makeKeyAndVisible];
//                    
//                    //-------------------------------------------------------------
//                    
////                    UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
////                                                                                             target:controller
////                                                                                             action:@selector(done:)];
////                    [[controller navigationItem] setRightBarButtonItem:button];
////                    [button release];
//                    
//                    //CGRect frame = view.bounds;
//                    
//                    //navBar = [[UINavigationBar alloc] initWithFrame:frame];
//                    navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds), 32.0)];
//                    //frame.size = [navBar sizeThatFits:frame.size];
//                    //[navBar setFrame:frame];
//                    [navBar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
//                    //[navBar setItems:[NSArray arrayWithObject:controller.navigationItem]];
//                    
//                    //navBar.barTintColor = [UIColor blueColor];
//                    //navController.navigationBar.tintColor = [UIColor blueColor];
//                    [navBar setBarTintColor:[UIColor blackColor]];
//                    [navBar setTintColor:[UIColor grayColor]];
//                    
//                    
//                    // 1. hide the existing nav bar
//                    //[navController setNavigationBarHidden:YES animated:NO];
//                    
//                    // 2. create a new nav bar and style it
////                    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds), 32.0)];
////                    [newNavBar setBarTintColor:[UIColor blackColor]];
////                    [newNavBar setTintColor:[UIColor grayColor]];
//                    
//                    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                               [UIColor whiteColor],NSForegroundColorAttributeName, nil]; //,
//                                                               //[UIColor grayColor], UITextAttributeTextShadowColor,
//                                                               //[NSValue valueWithUIOffset:UIOffsetMake(-1, 0)], UITextAttributeTextShadowOffset, nil];
//                    
//                    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
//                    
//                    // 3. add a new navigation item w/title to the new nav bar
//                    UINavigationItem *navItem = [[UINavigationItem alloc] init];
//                    navItem.title = @"Test";
//                    [navBar setItems:@[navItem]];
//                    
//                    // Add button
//                    ViewLoader *viewLoader = [[ViewLoader alloc] initWithNavigationController: navController];
//                    
//                    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit"
//                                                                                   style:UIBarButtonItemStylePlain
//                                                                                   target:viewLoader
//                                                                                   action:@selector(nextView:)];
//                    navItem.rightBarButtonItem = rightButton;
//                    
//                    
//                    // 4. add the nav bar to the main view
//                    [view addSubview:navBar];
//                    
//                    // UIBarButtonItem *sendButton = [[UIBarButtonItem alloc]
//                    //                                initWithTitle:@"Send"
//                    //                                style:UIBarButtonItemStylePlain
//                    //                                target:navController
//                    //                                action:@selector(sendEmail)];
//                    //
//                    // navController.navigationItem.rightBarButtonItem = sendButton;
//                    //
//                    //[view addSubview:navBar];
//                    //[controller.view addSubview:navBar];
//                    
//                    DBG ("Got UIWindow");
//                    
//                }
//
//            }

            
        }

        void closeButtonPressed() override
        {
            // This is called when the user tries to close this window. Here, we'll just
            // ask the app to quit when this happens, but you can change this to do
            // whatever you need.
            JUCEApplication::getInstance()->systemRequestedQuit();
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
