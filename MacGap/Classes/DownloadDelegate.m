//
//  DownloadDelegate.m
//  MacGap
//
//  Created by Jack Zhuang on 4/11/2014.
//  Copyright (c) 2014 SteedOS Inc. All rights reserved.
//

#import "DownloadDelegate.h"
#import "DownloadInfo.h"


@implementation DownloadDelegate {
    NSMapTable *downloads;
}

- (id)init
{
    self = [super init];
    if (self && NSClassFromString(@"NSProgress")) {
        downloads = [NSMapTable weakToStrongObjectsMapTable];
    }
    return self;
}


- (void)download:(NSURLDownload *)download decideDestinationWithSuggestedFilename:(NSString *)filename
{
    NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *destinationFilename = [downloadDir stringByAppendingPathComponent:filename];
    [download setDestination:destinationFilename allowOverwrite:NO];
}

-(void)download:(NSURLDownload *)download didCreateDestination:(NSString *)path
{
    if (downloads) {
        NSURL *downloadUrl = [NSURL fileURLWithPath:path];
        DownloadInfo *info = [downloads objectForKey:download];
        [info setFilename:path];
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                  NSProgressFileOperationKindDownloading,
                                  NSProgressFileOperationKindKey,
                                  nil];
        NSProgress *progress = [NSProgress progressWithTotalUnitCount:0];
        progress = [progress initWithParent:nil userInfo:userInfo];
        [progress setKind:NSProgressKindFile];
        [progress setUserInfoObject:downloadUrl forKey:NSProgressFileURLKey];
        [progress publish];
        [info setProgress:progress];
    }
}

- (void)download:(NSURLDownload *)download didReceiveResponse:(NSURLResponse *)response
{
    if (downloads) {
        DownloadInfo *info = [[DownloadInfo alloc] init];
        [info setResponse:response];
        [downloads setObject:info forKey:download];
    }
}

- (void)download:(NSURLDownload *)download didReceiveDataOfLength:(unsigned)length {
    if (downloads) {
        DownloadInfo *info = [downloads objectForKey:download];
        long long expectedLength = [[info response] expectedContentLength];
        int64_t completed = [[info progress] completedUnitCount];
        [[info progress] setCompletedUnitCount:(completed + length)];
        if (expectedLength != NSURLResponseUnknownLength) [[info progress] setTotalUnitCount:expectedLength];
    }
}

- (void)downloadDidFinish:(NSURLDownload *)download {
    if (downloads) {
        DownloadInfo *info = [downloads objectForKey:download];
        [[info progress] unpublish];
        [[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"com.apple.DownloadFileFinished" object:[info filename]];
        [downloads removeObjectForKey:download];
    }
}


@end
