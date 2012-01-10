#import "App.h"

@implementation App

- (void) terminate {
    [NSApp terminate:nil];
}

- (void) activate {
    [NSApp activateIgnoringOtherApps:YES];
}

- (void) hide {
    [NSApp hide:nil];
}

- (void) unhide {
    [NSApp unhide:nil];
}

- (void) onFloat{
    [[NSApplication sharedApplication].mainWindow setLevel:NSFloatingWindowLevel ];
}

- (void) offFloat{
    [[NSApplication sharedApplication].mainWindow setLevel:NSNormalWindowLevel ];
}

- (void)beep {
    NSBeep();
}

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
