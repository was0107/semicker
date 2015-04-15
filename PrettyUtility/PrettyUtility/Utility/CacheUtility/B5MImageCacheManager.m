//
//  B5MImageCacheManager.m
//  micker
//
//  Created by allen.wang on 7/4/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "B5MImageCacheManager.h"
#import "UIImage+extend.h"
#import <mach/mach.h>
#import <mach/mach_host.h>

//#define kCalculateLeftMemory    0             //open this marco means to check memory
//#define kCountLimit             64            //open this marco means to check count limation

#ifdef kCalculateLeftMemory

static natural_t minFreeMemLeft = 1024*1024*12; // reserve 12MB RAM

#endif


static B5MImageCacheManager *instance;

// inspired by http://stackoverflow.com/questions/5012886/knowing-available-ram-on-an-ios-device

NS_INLINE natural_t get_free_memory(void)
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
    {
        NSLog(@"Failed to fetch vm statistics");
        return 0;
    }
    
    /* Stats in bytes */
    natural_t mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}

@implementation B5MImageCacheManager

- (id)init
{
    if ((self = [super init]))
    {
        // Init the memory cache
        memCache = [[NSMutableDictionary alloc] init];
        
        // Init the operation queue
        cacheOutQueue = [[NSOperationQueue alloc] init];
        cacheOutQueue.maxConcurrentOperationCount = 8;
        
        theLock       = [[NSLock alloc] init];
        
#if TARGET_OS_IPHONE
        // Subscribe to app events
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_4_0
        UIDevice *device = [UIDevice currentDevice];
        if ([device respondsToSelector:@selector(isMultitaskingSupported)] && device.multitaskingSupported)
        {
            // When in background, clean memory in order to have less chance to be killed
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(clearMemory)
                                                         name:UIApplicationDidEnterBackgroundNotification
                                                       object:nil];
        }
#endif
#endif
    }
    
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(memCache);
    TT_RELEASE_SAFELY(cacheOutQueue);
    TT_RELEASE_SAFELY(theLock);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

+ (B5MImageCacheManager *)sharedImageCache
{
    if (!instance)
    {
        instance = [[B5MImageCacheManager alloc] init];
    }
    
    return instance;
}


- (void)notifyDelegate:(NSDictionary *)arguments
{
    NSString *key = [arguments objectForKey:kImageKey];
    id <B5MImageCacheDelegate> delegate = [arguments objectForKey:kImageDelegate];
    NSDictionary *info = [arguments objectForKey:kImageUserInfo];
    UIImage *image = [arguments objectForKey:kImageImage];
    
    if (image)
    {
        
#ifdef kCalculateLeftMemory
        if (get_free_memory() < minFreeMemLeft)
        {
            [theLock lock];
            [memCache removeAllObjects];
            [theLock unLock];

        }    
#endif
        
#ifdef kCountLimit
        if (kCountLimit < [self getMemoryCount])
        {
            [theLock lock];
            [memCache removeAllObjects];
            [theLock unlock];

        }  
#endif
        [theLock lock];
        [memCache setObject:image forKey:key];
        [theLock unlock];   
        
        if ([delegate respondsToSelector:@selector(imageCache:didFindImage:forKey:userInfo:)])
        {
            [delegate imageCache:self didFindImage:image forKey:key userInfo:info];
        }
    }
    else
    {
        if ([delegate respondsToSelector:@selector(imageCache:didNotFindImageForKey:userInfo:)])
        {
            [delegate imageCache:self didNotFindImageForKey:key userInfo:info];
        }
    }
}

- (void)queryImageCacheOperation:(NSDictionary *)arguments
{
    NSString *key = [arguments objectForKey:kImageKey];
    NSMutableDictionary *mutableArguments = [[arguments mutableCopy] autorelease];
    
    UIImage *image = [UIImage imageWithContentsOfFile:key];
    
    if (image)
    {
        if ([arguments objectForKey:kImageSize]) {
            CGSize   size = [[arguments objectForKey:kImageSize] CGSizeValue];
            UIImage *decodedImage = [image imageByScalingProportionallyToMinimumSize:size];//InlineScaledImageToMiniumuSize(image,size);
            if (decodedImage)
            {
                image = decodedImage;
            }
        }
        [mutableArguments setObject:image forKey:kImageImage];
    }
    
    [self performSelectorOnMainThread:@selector(notifyDelegate:) withObject:mutableArguments waitUntilDone:NO];
}



- (void)queryImageCacheForKey:(NSString *)key delegate:(id <B5MImageCacheDelegate>)delegate userInfo:(NSDictionary *)info
{
    NSParameterAssert(key);
    NSParameterAssert(delegate);
    
    if (!delegate || !key)
    {
        return;
    }
    
    NSMutableDictionary *arguments = [NSMutableDictionary dictionaryWithCapacity:3];
    [arguments setObject:key forKey:kImageKey];
    [arguments setObject:delegate forKey:kImageDelegate];
    if (info)
    {
        [arguments setObject:info forKey:kImageUserInfo];
    }
    
    NSInvocationOperation *operation = [[[NSInvocationOperation alloc] initWithTarget:self
                                                                             selector:@selector(queryImageCacheOperation:)
                                                                               object:arguments] autorelease];
    [cacheOutQueue addOperation:operation];
}

- (UIImage *)imageFromKey:(NSString *)key
{
    NSParameterAssert(key);

    if (!key)
    {
        return nil;
    }
    
    return [memCache objectForKey:key];
}

- (UIImage *)storeImageforKey:(NSString *)key withSize:(CGSize) size needToStore:(BOOL) flag 
{
    UIImage *theImage = [self imageFromKey:key];
    
    if (theImage) 
    {
        return theImage;
    }
    
    theImage = nil;
    
    @try {
        theImage = [UIImage imageWithContentsOfFile:key];
    }
    @catch (NSException *exception) {
        ERRLOG(@"read image from path = %@ error!",key);
        return nil;
    }
    @finally {
        
    }
    
    if (theImage)
    {
        UIImage *decodedImage = nil;
        
        @try {
            decodedImage = [theImage imageByScalingProportionallyToMinimumSize:size];
        }
        @catch (NSException *exception) {
            ERRLOG(@"scale image from path = %@ error!",key);
            return nil;
        }
        
        if (decodedImage)
        {
            theImage = decodedImage;
        }
        if (flag) 
        {
            [theLock lock];
            [memCache setObject:theImage forKey:key];
            [theLock unlock];
        }
    }
    return theImage;
}

- (void)clearMemory
{
    WARNLOG(@"clear Memory !");
    [cacheOutQueue cancelAllOperations]; // won't be able to complete
    
    [theLock lock];
    [memCache removeAllObjects];
    [theLock unlock];
}

- (NSUInteger)getMemorySize
{
    NSUInteger size = 0;
    NSArray *allKeys = [memCache allKeys];
    for(id key in allKeys)
    {
        UIImage *img = [memCache valueForKey:key];
        size += [UIImageJPEGRepresentation(img, 0) length];
    };
    
    return size;
}

- (NSUInteger)getMemoryCount
{
    return [[memCache allKeys] count];
}

@end
