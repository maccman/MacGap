#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class Nodejs;
@class Sound;
@class Dock;
@class Growl;
@class Path;
@class App;
@class Window;

@class WindowController;

@interface WebViewDelegate : NSObject {
    Nodejs* nodejs;
	Sound* sound;
    Dock* dock;
    Growl* growl;
    Path* path;
    App* app;
    Window* window;
}


@property (nonatomic, retain) Nodejs* nodejs;
@property (nonatomic, retain) Sound* sound;
@property (nonatomic, retain) Dock* dock;
@property (nonatomic, retain) Growl* growl;
@property (nonatomic, retain) Path* path;
@property (nonatomic, retain) App* app;
@property (nonatomic, retain) Window* window;

@property (nonatomic, retain) WindowController *requestedWindow;

@end
