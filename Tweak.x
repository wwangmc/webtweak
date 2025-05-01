#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    // 创建服务器实例
    GCDWebServer* webServer = [[GCDWebServer alloc] init];

    // 添加处理程序
    [webServer addDefaultHandlerForMethod:@"GET"
                            requestClass:[GCDWebServerRequest class]
                            processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
        return [GCDWebServerDataResponse responseWithHTML:@"<html><body><h1>Hello from Tweak!</h1></body></html>"];
    }];

    // 启动服务器
    [webServer startWithPort:8080 bonjourName:nil];
    NSLog(@"Server running on %@", webServer.serverURL);

}

%end