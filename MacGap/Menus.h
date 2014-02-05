//
//  Menus.h
//  MacGap
//
//  Created by Alberto Corbi Bellot on 30/08/13.
//  Copyright (c) 2013 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Webkit/Webkit.h>

@interface Menus : NSObject{
    
}
@property (nonatomic, retain) WebView *webView;
- (id) initWithWebView:(WebView *)view;
- (void) addMenu:(NSString *)menuTitle;

@end
