//
//  A wrapper class for storing all the information relevant to a particular download.
//
//  Created by Jack Zhuang on 4/11/2014.
//  Copyright (c) 2014 SteedOS Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface DownloadInfo : NSObject<NSCopying>

@property NSProgress *progress;
@property NSURLResponse *response;
@property NSString *filename;

- (id)copyWithZone:(NSZone *)zone;

@end
