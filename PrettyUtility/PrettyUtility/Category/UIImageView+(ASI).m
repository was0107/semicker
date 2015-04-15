//
//  UIImageView+(ASI).m
//  comb5mios
//
//  Created by allen.wang on 7/23/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "UIImageView+(ASI).h"
#import "B5MImageCacheManager.h"
#import "FileManager.h"
#import <objc/runtime.h>
#import "B5MDeviceDetact.h"
#import "CustomAnimation.h"

B5M_FIX_CATEGORY_BUG(UIImageView_ASI)

static NSUInteger maxConcurrentOperationCount = 8;

static char kWASImageRequestOperationObjectKey;
static char kWASImageDownloadRequestOperationObjectKey;
static char kWASImageRequestOperationSuccObjectKey;
static char kWASImageRequestOperationFailedObjectKey;
static char kWASImageRequestOperationErrorObjectKey;

@interface UIImageView (_ASITmp)
@property (readwrite, nonatomic, retain, setter = was_setImageRequestOperation:) NSBlockOperation *was_imageRequestOperation;
@property (readwrite, nonatomic, retain, setter = was_setDownloadImageRequestOperation:) NSBlockOperation *was_downloadRequestOperation;
@property (readwrite, nonatomic, copy, setter = was_setSuccesBlock:) VoidBlock succBlock;
@property (readwrite, nonatomic, copy, setter = was_setFaildBlock:)  VoidBlock failedBlock;
@property (readwrite, nonatomic, copy, setter = was_setErrorBlock:)  VoidBlock errorBlock;
@end

@implementation UIImageView (_ASITmp)
@dynamic was_imageRequestOperation;
@dynamic was_downloadRequestOperation;
@dynamic succBlock;
@dynamic failedBlock;
@dynamic errorBlock;
@end


@implementation UIImageView(ASI)

#pragma mark -

- (NSBlockOperation *)was_imageRequestOperation {
    return (NSBlockOperation *)objc_getAssociatedObject(self, &kWASImageRequestOperationObjectKey);
}

- (void)was_setImageRequestOperation:(NSBlockOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, &kWASImageRequestOperationObjectKey, imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSBlockOperation *)was_downloadRequestOperation {
    return (NSBlockOperation *)objc_getAssociatedObject(self, &kWASImageDownloadRequestOperationObjectKey);
}

- (void)was_setDownloadImageRequestOperation:(NSBlockOperation *)imageRequestOperation {
    objc_setAssociatedObject(self, &kWASImageDownloadRequestOperationObjectKey, imageRequestOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VoidBlock) succBlock {
    return (VoidBlock)objc_getAssociatedObject(self, &kWASImageRequestOperationSuccObjectKey);
}

- (VoidBlock) failedBlock {
    return (VoidBlock)objc_getAssociatedObject(self, &kWASImageRequestOperationFailedObjectKey);
}

- (VoidBlock) errorBlock {
    return (VoidBlock)objc_getAssociatedObject(self, &kWASImageRequestOperationErrorObjectKey);
}

- (void) was_setSuccesBlock:(VoidBlock) theSuccBlock
{
    objc_setAssociatedObject(self, &kWASImageRequestOperationSuccObjectKey, theSuccBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) was_setFaildBlock:(VoidBlock) theFailedBlock
{
    objc_setAssociatedObject(self, &kWASImageRequestOperationFailedObjectKey, theFailedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) was_setErrorBlock:(VoidBlock) theFailedBlock
{
    objc_setAssociatedObject(self, &kWASImageRequestOperationErrorObjectKey, theFailedBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (NSOperationQueue *)was_sharedImageRequestOperationQueue {
    static NSOperationQueue *_was_imageRequestOperationQueue = nil;
    
    if (!_was_imageRequestOperationQueue) {
        _was_imageRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_was_imageRequestOperationQueue setMaxConcurrentOperationCount:maxConcurrentOperationCount];
    }
    
    return _was_imageRequestOperationQueue;
}

+ (NSOperationQueue *)was_sharedDownloadImageRequestOperationQueue {
    static NSOperationQueue *_was_imageDownloadRequestOperationQueue = nil;
    
    if (!_was_imageDownloadRequestOperationQueue) {
        _was_imageDownloadRequestOperationQueue = [[NSOperationQueue alloc] init];
        [_was_imageDownloadRequestOperationQueue setMaxConcurrentOperationCount:maxConcurrentOperationCount];
    }
    
    return _was_imageDownloadRequestOperationQueue;
}

-(void)onFail:(VoidBlock)block
{
    [self was_setFaildBlock:block];
}

-(void)onSucc:(VoidBlock)block
{
    [self was_setSuccesBlock:block];
}
-(void)onError:(VoidBlock)block
{
    [self was_setErrorBlock:block];
}


-(void)cancelDownloadImage
{
    [[self was_downloadRequestOperation] cancel];
    [[self was_imageRequestOperation] cancel];
    [self was_setImageRequestOperation:nil];
    [self was_setDownloadImageRequestOperation:nil];
}

- (void) dealloc
{
    [self cancelDownloadImage];
    [super dealloc];
}


- (void)makeImageScale
{
    return;
    CGSize  size0  = self.image.size;
    CGFloat result = size0.height / size0.width;
    CGFloat factor = 1.0f;
    if (result > 1.5) {
        factor = 480.0f / size0.height;
    }
    else {
        factor = 320.0f / size0.width;
    }
    [self setTransform:CGAffineTransformMakeScale(factor, factor)];
}

- (void)setImageWithURL:(NSString *)linkURL 
           downloadPath:(NSString *)downloadPath
       placeholderImage:(NSString *)placeholderImageName
{
    [self cancelDownloadImage]; // cancel current download imgae block
    
    UIImage *cachedImage = [[B5MImageCacheManager sharedImageCache] imageFromKey:downloadPath];;
    
    if (cachedImage) {
        if (isIphoneDevice()) {
            self.image = cachedImage;
            if (self.succBlock) {
                self.succBlock();
            }
        }
        else {
            [CustomAnimation flipAnimationEx:self flipView:cachedImage];
        }
        
    } else {
            NSDictionary *dic  = [NSDictionary dictionaryWithObjectsAndKeys:
                                     linkURL,               @"linkURL",
                                     downloadPath,          @"downloadPath",
                                     placeholderImageName,  @"placeholderImage", nil];
            
            NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                     self, kImageDelegate,
//                                     [NSValue valueWithCGSize:self.frame.size],kImageSize,
                                     dic,kImageUserInfo,nil];
        
        __block UIImageView *blockSelf = self;
        VoidBlock block = ^(){
            [[B5MImageCacheManager sharedImageCache] queryImageCacheForKey:downloadPath delegate:blockSelf userInfo:userInfo];
        };

        [self was_setImageRequestOperation:[NSBlockOperation blockOperationWithBlock:block]];
        [[[self class] was_sharedImageRequestOperationQueue] addOperation:[self was_imageRequestOperation]];
        
    }
}


#pragma mark -
#pragma mark B5MImageCacheDelegate


- (void)imageCache:(B5MImageCacheManager *)imageCache didFindImage:(UIImage *)image forKey:(NSString *)key userInfo:(NSDictionary *)info
{
    [self cancelDownloadImage];
    
    if (isIphoneDevice()) {
        self.image = image;
        if (self.succBlock) {
            self.succBlock();
        }
    }
    else {
        [CustomAnimation flipAnimationEx:self flipView:image];
    }    
    [self makeImageScale];
}

- (void)imageCache:(B5MImageCacheManager *)imageCache didNotFindImageForKey:(NSString *)key userInfo:(NSDictionary *)info
{
    [self cancelDownloadImage];
    
    NSDictionary *userDic = [info objectForKey:kImageUserInfo];
    NSString *linkURL       = [userDic objectForKey:@"linkURL"];
    NSString *downloadPath  = [userDic objectForKey:@"downloadPath"];
    UIImage  *placeholderImage = [UIImage imageNamed: [userDic objectForKey:@"placeholderImage"]];
    
    if (!self.image && placeholderImage) {
        self.image = placeholderImage;
        [self makeImageScale];
    }
    
    if ([B5MUtility netWorkStatus] == 0) {
        return;
    }
    
//    __block 
    UIImageView *blockSelf = self;
    void (^block)() = ^
    {
        NSURL *url = [NSURL URLWithString:linkURL];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        [request setRequestMethod:@"GET"];
        [request setDownloadDestinationPath:downloadPath];
        NSDictionary *infoEx = [NSDictionary dictionaryWithObjectsAndKeys:downloadPath, @"downloadPath", nil];
        request.userInfo = infoEx;   
        request.delegate = nil;
        [request setCompletionBlock:^{  /* ALWAYS CALLED ON MAIN THREAD! FROM ASI */
            if (blockSelf && request) {
                [blockSelf finished:request];
            }
        } ];
        
        [request setFailedBlock:^{      /* ALWAYS CALLED ON MAIN THREAD! FROM ASI */
            if (blockSelf && request) {
                [blockSelf failed:request];
            }
        }];
        [request startSynchronous];
    };
    [self was_setDownloadImageRequestOperation:[NSBlockOperation blockOperationWithBlock:block]];
    [[[self class] was_sharedDownloadImageRequestOperationQueue] addOperation:[self was_downloadRequestOperation]];
}

- (void) finished:(ASIHTTPRequest *)request
{
    if ([[self was_downloadRequestOperation] isCancelled]) {
        DEBUGLOG(@"download operation is cancelled!");
        return;
    }
    NSDictionary *dic    = request.userInfo;
    NSString  *imagePath = [dic objectForKey:@"downloadPath"];
    if (imagePath) {
        UIImage *image   = [[B5MImageCacheManager sharedImageCache] storeImageforKey:imagePath  withSize:self.frame.size needToStore:YES];
        if (image) {
            
            if (isIphoneDevice()) {
                self.image = image;
            }
            else {
                [CustomAnimation flipAnimationEx:self flipView:image];
            } 
            
            [self makeImageScale];

            if (self.succBlock) {
                self.succBlock();
            }
        }
        else {
            if (self.errorBlock) {
                self.errorBlock();
            }
            [self failed:request];
        }

    }
}
- (void) failed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    DEBUGLOG(@"download image URL = %@  Error  %d",request.url, request.responseStatusCode);
    DEBUGLOG(@"%@",error);
    if ([[self was_downloadRequestOperation] isCancelled]) {
        DEBUGLOG(@"download operation is cancelled! error");
        return;
    }
    if (self.failedBlock) {
        self.failedBlock();
        self.failedBlock = nil;
    }
}

#pragma mark -
#pragma mark ASIHTTPRequestDelegate
- (void) requestFinished:(ASIHTTPRequest *)request 
{
    NSLog(@"requestFinished  %d>>>>>>", request.responseStatusCode);
    [self performSelectorOnMainThread:@selector(finished:) withObject:request waitUntilDone:NO];
    NSLog(@"requestFinished  %d<<<<<<", request.responseStatusCode);

}

- (void) requestFailed:(ASIHTTPRequest *)request {
    [self performSelectorOnMainThread:@selector(failed:) withObject:request waitUntilDone:NO];
}

@end
