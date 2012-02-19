//
//  NodeJS.m
//
//  Created by Christian Sullivan <cs@euforic.co>.
//  Copyright (c) 2012 euforic. All rights reserved.
//

#import "Nodejs.h"

@implementation Nodejs


//
// Start server process
//

- (void) startServer {
    serverProcess = [[NSTask alloc] init];
    
    // Path to the resources directory in app bundle
    NSString *resourcesPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/public"];    
    // Path to Node.js binary in app bundle
    NSString *nodePath = [resourcesPath stringByAppendingString:@"/bin/node"];
    // Path to server directory in app bundle
    NSString *serverPath = [resourcesPath stringByAppendingString:@"/node"];
    // Path to server.js file in app bundle
    NSString *serverJsPath = [resourcesPath stringByAppendingString:@"/node/app.js"];
    
    
    NSLog(@" %@ \n  %@ \n  %@", resourcesPath, serverPath, serverJsPath);
    
    [serverProcess setCurrentDirectoryPath:serverPath];
    [serverProcess setLaunchPath:nodePath];
    [serverProcess setArguments:[NSArray arrayWithObjects:serverJsPath,nil]];
    
    pipe=[NSPipe pipe];
    [serverProcess setStandardOutput:pipe];
    [serverProcess setStandardError:pipe];
    
    [[pipe fileHandleForReading] readInBackgroundAndNotify];
    
    
    [serverProcess launch];
}

- (void) stopServer {
    [serverProcess terminate];
    serverProcess = nil;
}

//
// Handle output from server process
//
-(void)handleServerOutput:(NSNotification*)notification{
    NSString* str = [[NSString alloc] initWithData:[[notification userInfo] objectForKey:NSFileHandleNotificationDataItem]
                                          encoding:NSASCIIStringEncoding];
    
    NSFileHandle *fileHandle = (NSFileHandle*)[notification object];
    
    if([str length] > 0){
        NSLog ( @"%@", str);
    }
    
    [fileHandle readInBackgroundAndNotify];
}

#pragma mark WebScripting Protocol

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
    return NO;
}

@end