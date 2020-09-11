//OSX Main - Entry point for the OSX platform.
#include <stdio.h>
#include <AppKit/AppKit.h>

static float GlobalRenderWidth = 1024;
static float GlobalRenderHeight = 768;
static bool Running = true;

//Declare an interface that inherits from NSObject and implements NSWindowDelegate.
@interface SimpleMainWindowDelegate: NSObject<NSWindowDelegate>
@end
@implementation SimpleMainWindowDelegate

- (void)windowWillClose:(id)sender {
    Running = false;
}

@end

int main(int argc, const char * argv[]) {

    SimpleMainWindowDelegate *mainWindowDelegate = [[SimpleMainWindowDelegate alloc] init];

    NSRect screenRect = [[NSScreen mainScreen] frame];
    NSRect initialFrame = NSMakeRect((screenRect.size.width - GlobalRenderWidth) * 0.5,
                                        (screenRect.size.height - GlobalRenderHeight) * 0.5,
                                        GlobalRenderWidth,
                                        GlobalRenderHeight);

    NSWindow *window = [[NSWindow alloc] initWithContentRect: initialFrame
                                            styleMask: NSWindowStyleMaskTitled |
                                                        NSWindowStyleMaskClosable |
                                                        NSWindowStyleMaskMiniaturizable |
                                                        NSWindowStyleMaskResizable
                                            backing:NSBackingStoreBuffered
                                            defer:NO];
    [window setBackgroundColor: NSColor.redColor];
    [window setTitle:@"simple-mac-window"];
    [window makeKeyAndOrderFront: nil];
    [window setDelegate: mainWindowDelegate];

	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];

    while(Running) {
        NSEvent* event;
        do {
            event = [NSApp nextEventMatchingMask: NSEventMaskAny
            untilDate: [NSDate distantFuture]
            inMode: NSDefaultRunLoopMode
            dequeue: YES];

            switch([event type]) {
                default:
                [NSApp sendEvent: event];
            }
        } while (event != nil);
    }

    printf("Finished running simple-mac-window.");
}
