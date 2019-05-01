//
//  MovieSearchViewController.swift
//  Movie Search
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController {
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var movieTableView: UITableView!
    @IBOutlet private var loadingView: UIActivityIndicatorView!
    @IBOutlet private var statusView: UIView!
    @IBOutlet private var statusViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var statusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

