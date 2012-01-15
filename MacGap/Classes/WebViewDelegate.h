#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@class Sound;
@class Dock;
@class Growl;
@class Path;
@class App;
@class MenuProxy;

@interface WebViewDelegate : NSObject {
    NSMenu *mainMenu;
}

@property (nonatomic, retain) Sound* sound;
@property (nonatomic, retain) Dock* dock;
@property (nonatomic, retain) Growl* growl;
@property (nonatomic, retain) Path* path;
@property (nonatomic, retain) App* app;
@property (nonatomic, retain) MenuProxy* menu;

- (id) initWithMenu:(NSMenu*)menu;
@end
