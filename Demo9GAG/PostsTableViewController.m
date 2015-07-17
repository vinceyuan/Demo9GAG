//
//  PostsTableViewController.m
//  Demo9GAG
//
//  Created by Vince Yuan on 16/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "PostsTableViewController.h"
#import "Downloader.h"
#import "Post.h"
#import "XibTableViewCell.h"
#import "PostsTableViewCell.h"
#import "SDWebImageManager.h"

@interface PostsTableViewController () <PostsTableViewCellDownloadDelegate>

@end

@implementation PostsTableViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _downloader = [[Downloader alloc] init];
        _posts = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

}

- (void)viewDidAppear:(BOOL)animated {
    _width = [UIScreen mainScreen].bounds.size.width;

    [_downloader downloadWithCompletion:^(NSArray *posts, NSError *error) {
        if (error) {

        } else {
            [_posts addObjectsFromArray:posts];
            [self.tableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_posts count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PostsTableViewCell";
    PostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (!cell) {
        cell = (PostsTableViewCell *)[PostsTableViewCell cellFromNibNamed:@"PostsTableViewCell"];
    }
    cell.downloadDelegate = self;
    // Configure the cell...
    [cell setupWithPosts:_posts index:indexPath.row width:_width];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Post *post = [_posts objectAtIndex:indexPath.row];
    float imageHeight = DEFAULT_IMAGE_HEIGHT;
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:post.imageUrl]) {
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[post.imageUrl absoluteString]];
        imageHeight = _width * image.size.height / image.size.width;
    }
    float height = 30 + imageHeight + 25;
    return height;
}

#pragma mark - PostsTableViewCellDownloadDelegate
- (void)postsTableViewCellDownloadedPostIndex:(NSInteger)index {
    // Delay reload
    [self performSelector:@selector(reloadCell:) withObject:[NSNumber numberWithInteger:index] afterDelay:0];
}

- (void)reloadCell:(NSNumber *)number {
    //[tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:[number integerValue] inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    //[tableView endUpdates];

}

@end
