Demo9GAG is a demo project made by Vince Yuan (vince.yuan@gmail.com). 

IDE:
Xcode 7 beta 3.

Highlights:
1. It implemented all requirements.
2. Scrolling is very smooth in both vertical and horizontal directions.
3. It loads real 9GAG posts and images of Hot/Trending/Fresh from a third party source. (The images of the top module are fake.)
4. Images are downloaded asynchronously and cached.
5. It shows progress bars when downloading images. (You'd better switch to a slow connection like 3G for better progress bar effects)
6. The third party source does not provide each image's width and height. It adjusts the image size after the image is downloaded.
7. It supports multiple lines of captions. Table view cell's height is calculated correctly.
8. The top module (horizontal scrolling) is implemented with a transformed uitableview.
9. Code is clean, well-organized and reusable.
10. Tapping the status bar can scroll the current table view to top.
11. Both unit test and UI test are implemented.
12. It handles memory carefully, and also deals with the memory warning.
13. It looks and feels like the official 9GAG app for iOS.
14. Used Git for source control. You can see all my changes.

Issues:
1. The third party data source is slow and not stable. This issue is handled in the app. When there is a problem, just pull to refresh. 
2. When the unit test fails because the server returns 500(Internal Server Error), just restart the unit test.

Libraries:
1. AFNetworking - for downloading JSON from the data source.
2. SVProgressHUD - for showing messages.
3. SDWebImage - for downloading and caching images.
Because the data source does not provide the image's width and height, I have to adjust the size of the image view after the image is downloaded. I did not use [UIImageview sd_setImageWithURL:placeholderImage:]. Instead, I download the images using [SDWebImageManager downloadImageWithURL:options:progress:completed:] and adjust the image view size and table view cell's height.

Code Structure:
1. The root view controller is a UINavigationController (for the navigation bar);
2. Downloader handles downloading JSON from the server. It can be used for Hot/Trending/Fresh.
3. PagedScrollViewController provides a paged scroll view. Each page is a table view of PostsTableViewController.
4. PostsTableViewController shows posts. It can be used for Hot/Trending/Fresh.
5. The table header view of Hot table view is a transformed table view of TopPostsTableViewController. 
6. PostsTableViewCell, LoadMoreTableViewCell, and TopPostsTableViewCell are customized UITableViewCell.

Good Practise:
1. To support the horizontal scroll and loading more easily, TopPostsTableViewController is actually a subclass of UITableViewController. The table view is transformed by 90 degree counter-clockwise and the table view cell's content view is transformed by 90 degree clockwise.
2. Used a helper label to calculate the size of multiple lines of caption to avoid the size difference when calculating by NSString.

License:
It's for interviewing with 9GAG only. All rights reserved by Vince Yuan (vince.yuan@gmail.com). It cannot be used for any other purpose. Distribution is not allowed.