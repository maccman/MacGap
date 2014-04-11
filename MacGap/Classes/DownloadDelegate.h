//
//  DownloadDelegate.h
//  MacGap
//
//  Created by Jack Zhuang on 4/11/2014.
//  Copyright (c) 2014 SteedOS Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadDelegate : NSObject {
    NSString *suggestedFilename;
    
    NSSavePanel *panel;
}

@end
