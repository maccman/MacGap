//
//  Menus.m
//  MacGap
//
//  Created by Alberto Corbi Bellot on 30/08/13.
//  Copyright (c) 2013 Twitter. All rights reserved.
//

#import "Menus.h"
#import "JSEventHelper.h"
#import "MF_Base64Additions.h"


@implementation Menus

@synthesize webView;

- (id) initWithWebView:(WebView *) view{
    self = [super init];
    
    if (self) {
        self.webView = view;
    }
    
    return self;
}

- (void) addMenu:(NSDictionary *)menuContents{
    NSMenuItem *newItem;
    NSMenu *newMenu;
    
    NSString *menuTitle = [menuContents valueForKey:@"menuTitle"];
    NSArray *menuItems = [menuContents valueForKey:@"menuItems"];
    NSUInteger count = [[menuItems valueForKey:@"length"] integerValue];
    newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:menuTitle action:nil keyEquivalent:@""];

    newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:menuTitle];
    
    int i;
    for (i = 0; i < count; i++){
        NSString *itemTitle = [[menuItems objectAtIndex:i] valueForKey:@"title"];
        NSString *itemKey, *menuItemChar;
        NSMenuItem *newItem;
        BOOL itemB64 = NO;
        menuItemChar = @"";
        @try {
            itemKey = [[menuItems objectAtIndex:i] valueForKey:@"key"];
            if ([itemKey length] > 0)
                menuItemChar = [itemKey substringFromIndex:[itemKey length] - 1];
         }
        @catch (NSException* e) {  // No key equivalent given, menuItemChar = ""
        }
        @try {
            itemB64 = [[[menuItems objectAtIndex:i] valueForKey:@"b64"] intValue];
            
        }
        @catch (NSException* e) {  // No key equivalent given, menuItemChar = ""
        }
        NSLog(@"itemB64 = %i", itemB64);
        if (itemB64 != 0) itemTitle = [NSString stringFromBase64String:itemTitle];
        NSLog(@"itemTitle = %@", itemTitle);
        newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:itemTitle action:@selector(menuTriggered:) keyEquivalent:menuItemChar];
        [newItem setTarget:self];
        
        NSUInteger modifiers = 0;
        if ([itemKey rangeOfString:@"cmd"].location != NSNotFound) modifiers += NSCommandKeyMask;
        if ([itemKey rangeOfString:@"ctrl"].location != NSNotFound) modifiers += NSControlKeyMask;
        if ([itemKey rangeOfString:@"alt"].location != NSNotFound) modifiers += NSAlternateKeyMask;
        if ([itemKey rangeOfString:@"shift"].location != NSNotFound) modifiers += NSShiftKeyMask;
        
        [newItem setKeyEquivalentModifierMask:modifiers];
        [newMenu addItem:newItem];
        
    }
    [newMenu setAutoenablesItems:YES];
    [newItem setSubmenu:newMenu];
    [[NSApp mainMenu] addItem:newItem];
}

-(void) menuTriggered:sender{
    NSString * str = [NSString stringWithFormat:@"var e = new CustomEvent('menucalled', {'detail': '%@'});  document.dispatchEvent(e);", [sender title]];
    [webView stringByEvaluatingJavaScriptFromString:str];
}


+ (BOOL) isSelectorExcludedFromWebScript:(SEL)selector
{
    return NO;
}

+ (NSString*) webScriptNameForSelector:(SEL)selector{
	id	result = nil;
	
	if (selector == @selector(addMenu:))
		result = @"addMenu";
	
	return result;
}

+ (BOOL) isKeyExcludedFromWebScript:(const char*)name
{
	return YES;
}

@end
