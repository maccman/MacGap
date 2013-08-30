//
//  Menus.m
//  MacGap
//
//  Created by Alberto Corbi Bellot on 30/08/13.
//  Copyright (c) 2013 Twitter. All rights reserved.
//

#import "Menus.h"
#import "JSEventHelper.h"

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
    NSLog(@"menuTitle = %@", menuTitle);
    NSArray *menuItems = [menuContents valueForKey:@"menuItems"];
    NSUInteger count = [[menuItems valueForKey:@"length"] integerValue];
    newItem = [[NSMenuItem allocWithZone:[NSMenu menuZone]] initWithTitle:menuTitle action:nil keyEquivalent:@""];

    newMenu = [[NSMenu allocWithZone:[NSMenu menuZone]] initWithTitle:menuTitle];
    
    int i;
    for (i = 0; i < count; i++){
        NSString *itemTitle = [[menuItems objectAtIndex:i] valueForKey:@"title"];
        NSString *itemKey = @"";
        itemKey = [[menuItems objectAtIndex:i] valueForKey:@"key"];
        NSLog(@"itemKey = %@", itemKey);
        NSMenuItem *newItem;
        NSString *menuItemChar = [itemKey substringFromIndex:[itemKey length] - 1];
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
