//
//  DetailViewController.m
//  PullToClose
//
//  Created by Jorge Bernal on 8/16/13.
//  Copyright (c) 2013 Jorge Bernal. All rights reserved.
//

#import "DetailViewController.h"
#import "PullToCloseProgressView.h"

@interface DetailViewController () <UITextViewDelegate>
@end

@implementation DetailViewController {
    IBOutlet UITextView *_textView;
    UIView *_closeView;
    UILabel *_closeLabel;
    PullToCloseProgressView *_progressView;
}

- (void)dealloc
{
    _textView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _textView.delegate = self;
    [_textView sizeToFit];
    CGRect frame = _textView.frame;
    frame.origin.y = frame.size.height;
    _closeView = [[UIView alloc] initWithFrame:frame];
    _closeView.backgroundColor = [UIColor lightGrayColor];
    [_textView addSubview:_closeView];
    frame.size.height = 66.f;
    _closeLabel = [[UILabel alloc] initWithFrame:frame];
    _closeLabel.text = @"Pull to close";
    _closeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_closeLabel];
    frame.size = CGSizeMake(16.f, 16.f);
    _progressView = [[PullToCloseProgressView alloc] initWithFrame:frame];
    [self.view addSubview:_progressView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"Begin dragging");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (!scrollView.isDragging && !scrollView.isDecelerating) {
        return;
    }
    CGFloat visibleSize = [self visibleFooterSize];
    NSLog(@"visible: %f", visibleSize);
    if (visibleSize < 0) {
        visibleSize = 0;
    } else if (visibleSize > 66.f) {
        visibleSize = 66.f;
        _closeLabel.text = @"Release to close";
    } else {
        _closeLabel.text = @"Pull to close";
    }
    [_closeLabel sizeToFit];
    CGRect frame = _closeLabel.frame;
    frame.origin.x = CGRectGetMidX(self.view.bounds) - CGRectGetWidth(frame) / 2.f;
    frame.origin.y = self.view.frame.size.height - visibleSize + 22.f;
    _closeLabel.frame = CGRectIntegral(frame);
    NSLog(@"frame: %@", NSStringFromCGRect(frame));
    frame = _progressView.frame;
    frame.origin.x = CGRectGetMinX(_closeLabel.frame) - CGRectGetWidth(frame) - 10.f;
    frame.origin.y = CGRectGetMidY(_closeLabel.frame) - CGRectGetHeight(frame) / 2.f;
    _progressView.frame = frame;
    _progressView.progress = visibleSize / 66.f;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self visibleFooterSize] >= 66.f) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (CGFloat)visibleFooterSize
{
    return _textView.contentOffset.y + _textView.frame.size.height - _textView.contentSize.height;
}

@end
