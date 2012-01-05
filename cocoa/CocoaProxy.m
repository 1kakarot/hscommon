#import "CocoaProxy.h"

@implementation CocoaProxy
- (void)openPath:(NSString *)path
{
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:path]];
}

- (void)revealPath:(NSString *)path
{
    [[NSWorkspace sharedWorkspace] selectFile:path inFileViewerRootedAtPath:@""];
}

- (NSString *)getUTI:(NSString *)path
{
    NSError *error;
    return [[NSWorkspace sharedWorkspace] typeOfFile:path error:&error];
}

- (BOOL)type:(NSString *)type conformsToType:(NSString *)refType
{
    return [[NSWorkspace sharedWorkspace] type:type conformsToType:refType];
}

- (NSString *)getAppdataPath
{
    return [NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}
- (NSString *)getCachePath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

- (NSString *)getResourcePath
{
    return [[[NSBundle mainBundle] resourceURL] path];
}

- (NSString *)systemLang
{
    return [[NSBundle preferredLocalizationsFromArray:[[NSBundle mainBundle] localizations]] objectAtIndex:0];
}

- (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:userInfo];
}

- (id)prefValue:(NSString *)prefname
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:prefname];
}

- (void)setPrefValue:(NSString *)prefname value:(id)value
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:prefname];
}

- (id)prefValue:(NSString *)prefname inDomain:(NSString *)domain
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] persistentDomainForName:domain];
    return [dict objectForKey:prefname];
}

// Changes a file:/// path into a normal path
- (NSString *)url2path:(NSString *)url
{
    NSURL *u = [NSURL URLWithString:url];
    return [u path];
}

// Create a pool for use into a separate thread.
- (void)createPool
{
    [self destroyPool];
    currentPool = [[NSAutoreleasePool alloc] init];
}
- (void)destroyPool
{
    if (currentPool != nil) {
        [currentPool release];
        currentPool = nil;
    }
}

@end