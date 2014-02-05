//
//  AppDelegate.m
//  MacGap
//
//  Created by Alex MacCaw on 08/01/2012.
//  Copyright (c) 2012 Twitter. All rights reserved.
//

#import "AppDelegate.h"
#import "MF_Base64Additions.h"

@implementation AppDelegate

@synthesize webView;
@synthesize windowController;

- (void) applicationWillFinishLaunching:(NSNotification *)aNotification{
    
}

-(BOOL)applicationShouldHandleReopen:(NSApplication*)application
                   hasVisibleWindows:(BOOL)visibleWindows{
    if(!visibleWindows){
        [self.windowController.window makeKeyAndOrderFront: nil];
    }
    return YES;
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification { 
    self.windowController = [[WindowController alloc] initWithURL: kStartPage];
    [self.windowController showWindow: [NSApplication sharedApplication].delegate];
    self.windowController.contentView.webView.alphaValue = 1.0;
    self.windowController.contentView.alphaValue = 1.0;
    [self.windowController showWindow:self];
}

// We can open files by sending the fileopen event
- (BOOL)application:(NSApplication*)app openFile:(NSString *)filename{
    NSString *data = [NSData dataWithContentsOfFile:filename];
    NSString *str64 = [data base64String];
    NSString *str = [NSString stringWithFormat:@"var e = new CustomEvent('fileopen', {'detail': {'path': '%@', 'data': '%@'}});  document.dispatchEvent(e);", filename, str64];
    [self.webView stringByEvaluatingJavaScriptFromString:str];

    return YES;
}


@end
