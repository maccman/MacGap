//
//  Created by Jack Zhuang on 4/11/2014.
//  Copyright (c) 2014 SteedOS Inc. All rights reserved.
//


#import "DownloadInfo.h"

@implementation DownloadInfo

- (id)copyWithZone:(NSZone *)zone
{
    DownloadInfo *copy = [[[self class] alloc] init];
    
    if (copy) {
        copy.progress = self.progress;
        copy.response = self.response;
        copy.filename = self.filename;
    }
    
    return copy;
}

@end
