#import <GCDWebServers/GCDWebServer.h>
#import <GCDWebServers/GCDWebServerDataResponse.h>
#import <UIKit/UIKit.h>


%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    GCDWebServer *webServer = [[GCDWebServer alloc] init];

    [webServer addHandlerForMethod:@"GET" path:@"/test" requestClass:[GCDWebServerRequest class] processBlock:^GCDWebServerResponse *(GCDWebServerRequest *request) {
        NSDictionary *jsonData = @{
            @"version": @"1035",
            @"value": @{
                @"timeZone": @"GMT-0700",
                @"currentLocale": @"zh-Hans_US",
                @"model": @"iPhone",
                @"uuid": @"E133F343-E2BE-436B-AD70-1299E095D32C",
                @"thermalState": @(0),
                @"userInterfaceIdiom": @(0),
                @"userInterfaceStyle": @"light",
                @"name": @"iPhone XR",
                @"isSimulator": @(false)
            }
            };

        return [GCDWebServerDataResponse responseWithJSONObject:jsonData];
    }];
    
    // 启动服务器（默认端口8080）
    // 启动服务器（默认端口8080）
    [webServer startWithPort:8080 bonjourName:nil];
    NSLog(@"GCDWebServer running on %@", webServer.serverURL);
}

%end