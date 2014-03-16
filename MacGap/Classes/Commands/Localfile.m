//
//  Localfile.m
//  Kato
//
//  Created by JLarky on 16.03.14.
//  Copyright (c) 2014 LeChat, Inc. All rights reserved.
//

#import "Localfile.h"

@implementation Localfile

- (NSString *) read:(NSString*)fileNeeded {
    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:@"unknown", @"error", nil];
    NSString *whitelistFile = [[Utils sharedInstance] pathForResource:@"public/localfiles.whitelist"];
    if (!whitelistFile) {
        result = [NSDictionary dictionaryWithObjectsAndKeys:@"localfiles.whitelist can't be read", @"error", nil];
    } else {
        NSString* fileContents =
            [NSString stringWithContentsOfFile:whitelistFile
             encoding:NSUTF8StringEncoding error:nil];
        // separate by new line
        NSArray* allLinedStrings =
            [fileContents componentsSeparatedByCharactersInSet:
             [NSCharacterSet newlineCharacterSet]];
        // search for fileNeeded in whitelist
        if ([allLinedStrings indexOfObject:fileNeeded] == NSNotFound) {
            result = [NSDictionary dictionaryWithObjectsAndKeys:@"requested file not in localfiles.whitelist", @"error", nil];
        } else {
            NSString *filename;
            NSString *resourceFile = [[Utils sharedInstance] pathForResource:fileNeeded];
            if (resourceFile) {
                filename = resourceFile;
            } else {
                filename =[fileNeeded stringByExpandingTildeInPath];
            }
            NSError *readError = nil;
            NSString* content =
                [NSString stringWithContentsOfFile:filename
                 encoding:NSUTF8StringEncoding
                 error:&readError];
            if (readError) {
                result = [NSDictionary dictionaryWithObjectsAndKeys:[readError localizedDescription], @"error", nil];
            } else {
                result = [NSDictionary dictionaryWithObjectsAndKeys:content, @"content", nil];
            }
        }
    }
    NSError *writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:result options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

// macgap.localfile.read("~/Library/Application Support/Kato/userstyle.css")

+ (NSString*) webScriptNameForSelector:(SEL)selector
{
	id	result = nil;
	
	if (selector == @selector(read:)) {
        result = @"read";
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
