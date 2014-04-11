#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "DownloadDelegate.h"

@class WebViewDelegate;

@interface ContentView : NSView {
	IBOutlet WebView* webView;
	WebViewDelegate* delegate;
    DownloadDelegate* downloadDelegate;
}

@property (retain) WebView* webView;
@property (retain) WebViewDelegate* delegate;
@property (retain) DownloadDelegate* downloadDelegate;
@property (strong) IBOutlet NSMenu *mainMenu;

@end
