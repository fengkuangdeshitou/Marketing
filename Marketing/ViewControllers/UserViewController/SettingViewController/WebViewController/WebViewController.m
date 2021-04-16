//
//  WebViewController.m
//  Marketing
//
//  Created by 王帅 on 2021/4/14.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "CustomWebView.h"

@interface WebViewController ()<WKNavigationDelegate>

@property(nonatomic,copy)NSString *html;
@property(nonatomic,weak)IBOutlet CustomWebView * webView;

@end

@implementation WebViewController

- (instancetype)initWithHtml:(NSString *)html
{
    self = [super init];
    if (self) {
        self.html = html;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.html]]];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    self.title = webView.title;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
