//
//  FileSystem.m
//  MacGap
//
//  Created by Alberto Corbi Bellot on 03/09/13.
//  Copyright (c) 2013 Twitter. All rights reserved.
//

#import "FileSystem.h"

@implementation FileSystem

+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

// Allows to write a string to a file path. For now, there's no error handling (error:NULL)
-(void) stringToFile:(NSDictionary*) pathAndData{
    NSString *data = [pathAndData valueForKey:@"data"];
    NSString *path = [[pathAndData valueForKey:@"path"] stringByExpandingTildeInPath];
    [data writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:NULL];
}


+ (NSString*) webScriptNameForSelector:(SEL)selector{
	id	result = nil;
    if (selector == @selector(stringToFile:))
		result = @"stringToFile";
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
