//
//  Nodejs.h
//
//  Created by Christian Sullivan <cs@euforic.co>.
//  Copyright (c) 2012 euforic. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface Nodejs : NSObject{
    NSTask *serverProcess;
    NSPipe *pipe;
}

- (void)startServer;

- (void)stopServer;


@end
