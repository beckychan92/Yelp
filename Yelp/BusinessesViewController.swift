//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate  {
    
    //UITableViewDataSource,

    var businesses: [Business]!
    var searchBar: UISearchBar!
    var filterbusinesses: [Business]!
    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120


        //layout
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.setBackgroundImage(UIImage(named: "layout3"), for: .default)
            navigationBar.tintColor = UIColor(red: 1.0, green: 0.25, blue: 0.25, alpha: 0.8)
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if self.filterbusinesses != nil {
                return filterbusinesses!.count
            } else {
                return 0
            }
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
            
            cell.business = businesses[indexPath.row]
            
            return cell
        }
        
        
        //Search bar
        self.searchBar = UISearchBar()
        self.searchBar.sizeToFit()
        navigationItem.titleView = self.searchBar
        
        
        //Display a list of businesses 
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            if let businesses = businesses {
                for business in businesses {
                    print(business.name!)
                    print(business.address!)
                }
            }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */

//     //search
//        UIsearchDisplayController?.displaysSearchBarInNavigationBar = true
//        searchController.searchBar.sizeToFit()
//        navigationItem.titleView = searchController.searchBar
//        searchController.hidesNavigationBarDuringPresentation = false
        
        
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
            self.filterbusinesses = searchText.isEmpty ? businesses : businesses?.filter({ (dataString:Business) -> Bool in
            return dataString.name!.range(of: searchText, options: .caseInsensitive) != nil
            })
        }
        
        
        
        
//        func searchBarTextDidEndEditing(_: <#T##searchBar: UISearchBar##UISearchBar#>){
//        
//        }
//
//        func searchBarCancelButtonClicked(<#T##searchBar: UISearchBar##UISearchBar#>){
//        
//        }
        

    
    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

}
}
