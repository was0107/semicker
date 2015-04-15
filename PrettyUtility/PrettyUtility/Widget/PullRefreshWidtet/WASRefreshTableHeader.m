//
//  WASRefreshTableHeader.m
//  micker
//
//  Created by allen.wang on 8/17/12.
//  Copyright (c) 2012 b5m. All rights reserved.
//

#import "WASRefreshTableHeader.h"



#pragma mark -- WASRefreshTableHeader private

@interface WASRefreshTableHeader()

@property (nonatomic, retain) UILabel *lastUpdatedLabel;
@property (nonatomic, retain) UILabel *statusLabel;
@property (nonatomic, retain) CALayer *arrowImage;
@property (nonatomic, retain) UIImageView *headerImageView;

- (void) layoutItems;

@end

#pragma mark -- WASRefreshTableHeader 

@implementation  WASRefreshTableHeader
@synthesize lastUpdatedLabel    = _lastUpdatedLabel;
@synthesize statusLabel         = _statusLabel;
@synthesize arrowImage          = _arrowImage;
@synthesize activityView        = _activityView;
@synthesize state               = _state;
@synthesize viewType            = _viewType;
@synthesize headerImageView     = _headerImageView;
@synthesize spinner             = _spinner;

- (id)initWithFrame:(CGRect)frame
{    
    [NSException raise:@"Incomplete initializer"
                format:@"RefreshTableHeader must be initialized with a eViewType.\
     Use the initWithFrame:type: method."];
    return nil;
}

- (id)initWithFrame:(CGRect) frame type:(eViewType) theType
{
    self = [super initWithFrame:CGRectIntegral(frame)];
    if (self) 
    {
        // Initialization code
        [self lastUpdatedLabel];
        [self statusLabel];
        [self arrowImage];
        [self activityView];
        _viewType = theType;
        
        if (_viewType >= eTypeHeader || _viewType <= eTypeHeaderImage ) {
            [self setState:eHeaderRefreshNormal];
        }
        else if (_viewType >= eTypeFooter || _viewType <= eTypeFooterImage) {
            [self setState:eFooterReloadNormal];
        }


        [self layoutItems];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIImageView *) headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        [self addSubview:_headerImageView];
    }
    return _headerImageView;
}


- (UILabel *)lastUpdatedLabel
{
    if (!_lastUpdatedLabel) 
    {
        _lastUpdatedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_lastUpdatedLabel.autoresizingMask  = UIViewAutoresizingFlexibleWidth;
		_lastUpdatedLabel.font              = [UIFont systemFontOfSize:12.0f];
		_lastUpdatedLabel.textColor         = CONTENT_TEXT_COLOR;
		_lastUpdatedLabel.shadowColor       = [UIColor colorWithWhite:0.9f alpha:1.0f];
		_lastUpdatedLabel.shadowOffset      = CGSizeMake(0.0f, 1.0f);
		_lastUpdatedLabel.backgroundColor   = [UIColor clearColor];
		_lastUpdatedLabel.textAlignment     = NSTextAlignmentCenter;
		[self addSubview:_lastUpdatedLabel];
    }
    return _lastUpdatedLabel;
}

- (UILabel *) statusLabel
{
    if (!_statusLabel) 
    {
        _statusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_statusLabel.autoresizingMask   = UIViewAutoresizingFlexibleWidth;
		_statusLabel.font               = [UIFont fontWithName:@"Times New Roman" size:13.0f];
		_statusLabel.textColor          = CONTENT_TEXT_COLOR;
		_statusLabel.shadowColor        = [UIColor colorWithWhite:0.9f alpha:1.0f];
		_statusLabel.shadowOffset       = CGSizeMake(0.0f, 1.0f);
		_statusLabel.backgroundColor    = [UIColor clearColor];
		_statusLabel.textAlignment      = NSTextAlignmentCenter;
		[self addSubview:_statusLabel];   
    }
    
    return _statusLabel;
}

- (SpinnerView *)spinner
{
    if (!_spinner) {
        _spinner = [[SpinnerView alloc] initWithFrame:CGRectZero];
        [self addSubview:_spinner];

    }
    return _spinner;
}

- (CALayer *)arrowImage
{
    if (!_arrowImage) 
    {
        _arrowImage = [[CALayer alloc] init];
		_arrowImage.contentsGravity = kCAGravityResizeAspect;
		[[self layer] addSublayer:_arrowImage];   
    }
    
    return _arrowImage;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView) 
    {
        _activityView   = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityView.hidesWhenStopped  = YES;
		[self addSubview:_activityView];
    }
    
    return _activityView;
}

- (void)layoutItems
{
    CGRect rect     = self.frame;
    
    if (eTypeHeader == _viewType) 
    {
        _activityView.frame         = CGRectMake(25.0f,rect.size.height - 38.0f, 20.0f, 20.0f);
        _arrowImage.frame           = CGRectMake(5.0f, rect.size.height - 52.f,  60.0f, 46.0f);
        _statusLabel.frame          = CGRectMake(0.0f, rect.size.height - 48.0f, rect.size.width, 20.0f);
        _lastUpdatedLabel.frame     = CGRectMake(0.0f, rect.size.height - 30.0f, rect.size.width, 20.0f);
        _arrowImage.contents        = (id)[UIImage imageNamed:@"blueArrow.png"].CGImage;
    }
    else if (eTypeHeaderImage == _viewType)
    {
        self.headerImageView.frame  = CGRectMake(100.0f, rect.size.height - 60.f,  120.0f, 60.0f);
        self.headerImageView.image  = [UIImage imageNamed:@"270-160-new-log"];
    }
    else if(eTypeFooter == _viewType)
    {
        _statusLabel.frame          = CGRectMake(90, 0, 140, 18);
        _activityView.frame         = CGRectMake(100.0f, 0.0f, 18, 18);
    }
    else if(eTypeFooterImage == _viewType)
    {
        [self spinner].frame        = CGRectMake(140.0f, 0.0f, kReloadOffsetY, 2.0f);
    }
}

- (void)setCurrentDate
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setAMSymbol:@"AM"];
	[formatter setPMSymbol:@"PM"];
	[formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss at"];
	NSString *strTime = NSLocalizedString(@"最后刷新:",@"");
	strTime = [strTime stringByAppendingString:[formatter stringFromDate:[NSDate date]]];
	_lastUpdatedLabel.text = [NSString stringWithString:strTime];
	[[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:@"EGORefreshTableView_LastRefresh"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	[formatter release];
}

- (void)setState:(eRefreshAndReloadState)aState
{
    switch (aState) 
    {
        case eHeaderRefreshPulling:
        {
            _statusLabel.text = NSLocalizedString(@"松开即可刷新...",@"");
            _arrowImage.hidden = NO;
            _activityView.hidden = YES;
            [CATransaction begin];
            [CATransaction setAnimationDuration:.18];
            _arrowImage.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
        }
            break;
        case eHeaderRefreshNormal:
        {
            if (_state == eHeaderRefreshPulling) 
            {
                [CATransaction begin];
                [CATransaction setAnimationDuration:.18];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
            _arrowImage.hidden = NO;
            _activityView.hidden = YES;
            _statusLabel.text = NSLocalizedString(@"下拉可以刷新...",@"");
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
        }
            break;
        case eHeaderRefreshLoading:
        {
            _statusLabel.text = NSLocalizedString(@"刷新中...",@"");
            
            _arrowImage.hidden = YES;
            _activityView.hidden = NO;
            [_activityView startAnimating];
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
            _arrowImage.hidden = YES;
            [CATransaction commit];
        }
            break;
        case eFooterReloadPulling:
        {
            _statusLabel.text = NSLocalizedString(@"松开即可开始加载...",@"");
            _arrowImage.hidden = NO;
            _activityView.hidden = YES;
            [CATransaction begin];
            [CATransaction setAnimationDuration:.18];
            _arrowImage.transform = CATransform3DMakeRotation(M_PI, 0.0f, 0.0f, 1.0f);
            [CATransaction commit];
        }
            break;
        case eFooterReloadNormal:
        {
            if (_state == eFooterReloadPulling) 
            {
                [CATransaction begin];
                [CATransaction setAnimationDuration:.18];
                _arrowImage.transform = CATransform3DIdentity;
                [CATransaction commit];
            }
            
            _arrowImage.hidden = NO;
            _activityView.hidden = YES;
            _statusLabel.text = NSLocalizedString(@"上拉加载更多",@"");
            [_activityView stopAnimating];
            
            [CATransaction begin];
            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
            _arrowImage.hidden = NO;
            _arrowImage.transform = CATransform3DIdentity;
            [CATransaction commit];
        }
            break;
        case eFooterReloadLoading:
        {
            _statusLabel.text = NSLocalizedString(@"给力加载中...",@"");
            _activityView.hidden = NO;
            [_activityView startAnimating];
            //            [CATransaction begin];
            //            [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
            //            _arrowImage.hidden = YES;
            //            [CATransaction commit];
        }
            break;
        case eFooterReloadReachEnd:
        {
            _activityView.hidden    = YES;
            _arrowImage.hidden      = YES;
            _statusLabel.text       = NSLocalizedString(@"没有了哦!", @"");
        }
            break;
            
        default:
            break;
    }
    _state = aState;
}

- (void)dealloc 
{
	[_activityView release ],       _activityView       = nil;
	[_statusLabel release ],        _statusLabel        = nil;
	[_arrowImage release ],         _arrowImage         = nil;
	[_lastUpdatedLabel release],    _lastUpdatedLabel   = nil;
    [_headerImageView    release],  _headerImageView    = nil;
    [_spinner release],             _spinner            = nil;
    
    [super dealloc];
}

@end
