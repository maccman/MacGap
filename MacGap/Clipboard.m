//
//  clipboard.m
//  MacGap
//
//  Created by David Zorychta on 2013-07-22.
//  Copyright (c) 2013 Twitter. All rights reserved.
//

#import "Clipboard.h"

@implementation Clipboard

- (void) copy:(NSString*)text {
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] setString:text  forType:NSStringPboardType];
}

- (NSString *) paste {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSArray *classArray = [NSArray arrayWithObject:[NSString class]];
    NSDictionary *options = [NSDictionary dictionary];
    BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
    if (ok) {
        NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];
        return (NSString *) [objectsToPaste objectAtIndex:0];
    }
    return @"";
}

- (NSString *) pasteImage {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSArray *classArray = [NSArray arrayWithObject:[NSImage class]];
    NSDictionary *options = [NSDictionary dictionary];
    BOOL ok = [pasteboard canReadObjectForClasses:classArray options:options];
    if (ok) {
        NSArray *objectsToPaste = [pasteboard readObjectsForClasses:classArray options:options];
        NSImage *image = [objectsToPaste objectAtIndex:0];
        [image lockFocus];
        NSBitmapImageRep *bitmapRep = [[NSBitmapImageRep alloc] initWithFocusedViewRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
        [image unlockFocus];
        NSData *imageData = [bitmapRep representationUsingType:NSPNGFileType properties:nil];;
        NSString *base64String = [imageData base64EncodedStringWithOptions:0];
        return base64String;
    }
    return @"";
}

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	
	if (selector == @selector(copy:)) {
        result = @"copy";
    }
	
	return result;
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
