//
//  ViewController.m
//  PokerViewExample
//
//  Created by zuckchen on 11/12/15.
//  Copyright © 2015 zuckchen. All rights reserved.
//

#import "ViewController.h"
#import "PokerView.h"

#define ItemHeight      300
#define ItemWidth       300
#define ItemCount       20

@interface ViewController () {
    PokerView *_pokerView;
    BOOL _isHorizontalLayout;
    UIBarButtonItem *_settingItem;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _isHorizontalLayout = NO;
    
    self.navigationController.toolbarHidden = NO;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.toolbar setTranslucent:NO];
    
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    _settingItem = [[UIBarButtonItem alloc]initWithTitle:@"Horizonal" style:UIBarButtonItemStylePlain target:self action:@selector(onClick:)];
    self.toolbarItems = [NSArray arrayWithObjects:flexible, _settingItem, flexible, nil];
    
    NSArray *colorArray = [NSArray arrayWithObjects:[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor], [UIColor grayColor], nil];
    NSMutableArray *viewArray = [NSMutableArray array];
    for (NSInteger i = 0; i < ItemCount; i++) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = colorArray[i % colorArray.count];
        view.layer.borderWidth = 1;
        view.layer.borderColor = [[UIColor blackColor] CGColor];
        [viewArray addObject:view];
    }
    
    _pokerView = [[PokerView alloc]initWithFrame:self.view.bounds itemViews:viewArray];
    _pokerView.backgroundColor = [UIColor cyanColor];
    _pokerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _pokerView.isHorizontalLayout = _isHorizontalLayout;
    _pokerView.itemSize = CGSizeMake(ItemWidth, ItemHeight);
    [self.view addSubview:_pokerView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClick:(id)sender {
    _isHorizontalLayout = !_isHorizontalLayout;
    _pokerView.isHorizontalLayout = _isHorizontalLayout;
    
    if (_isHorizontalLayout) {
        _settingItem.title = @"Vertical";
    } else {
        _settingItem.title = @"Horizonal";
    }
}

@end
