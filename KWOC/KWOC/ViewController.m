//
//  ViewController.m
//  KWOC
//
//  Created by 渴望 on 2023/6/14.
//

#import "ViewController.h"
#import "TabBarDemoVC.h"
#import <KW-Swift.h>
#import "SizeO.h"
#import "KWColorDemo.h"
#import "KWNavigationVC.h"
#import "TestBaseVC.h"
#import "TestTableView.h"
#import "TestCollectionView.h"
#import "KOPageVC.h"
#import "UIViewExtShow.h"
#import "UIButtonExtShow.h"
#import "UITextFieldExtShow.h"
#import "MBProgressHUDShow.h"
#import "MasnorySnapKitShow.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, copy) NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.dataArr = @[@"KWTabBar",
                     @"KWColor",
                     @"KWNavigationController",
                     @"KWViewController",
                     @"KWTableView",
                     @"KWCollectionView",
                     @"KWPageController",
                     @"UIViewExt拓展方法",
                     @"UIButtonExt拓展方法",
                     @"UITextField拓展方法",
                     @"UIImageView拓展方法",
                     @"MBProgressHUD封装",
                     @"Masnory/SnapKit"];
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationStatusHeight(), kScreenWidth(), kScreenHeight()-kNavigationStatusHeight()) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    if (@available(iOS 15.0, *)) {
        tableView.sectionHeaderTopPadding = 0;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row]];
    cell.textLabel.text = self.dataArr[indexPath.row];
    cell.backgroundColor = UIColor.whiteColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        TabBarDemoVC * vc = [[TabBarDemoVC alloc]init];
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.row == 1) {
        KWColorDemo * vc = [[KWColorDemo alloc]init];
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.row == 2) {
        KWNavigationVC * vc = [[KWNavigationVC alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 3) {
        TestBaseVC * vc = [[TestBaseVC alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 4) {
        TestTableView * vc = [[TestTableView alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 5) {
        TestCollectionView * vc = [[TestCollectionView alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 6) {
        KOPageVC * vc = [[KOPageVC alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 7) {
        UIViewExtShow * vc = [[UIViewExtShow alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 8) {
        UIButtonExtShow * vc = [[UIButtonExtShow alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 9) {
        UITextFieldExtShow * vc = [[UITextFieldExtShow alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 10) {
        UITextFieldExtShow * vc = [[UITextFieldExtShow alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 11) {
        MBProgressHUDShow * vc = [[MBProgressHUDShow alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }else if (indexPath.row == 12) {
        MasnorySnapKitShow * vc = [[MasnorySnapKitShow alloc]init];
        KWNavigationController * nav = [[KWNavigationController alloc]initWithRootViewController:vc];
        [UIApplication sharedApplication].windows.firstObject.rootViewController = nav;
        [[UIApplication sharedApplication].windows.firstObject makeKeyAndVisible];
    }
}







@end
