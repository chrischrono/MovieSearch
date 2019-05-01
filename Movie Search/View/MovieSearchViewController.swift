//
//  MovieSearchViewController.swift
//  Movie Search
//
//  Created by Christian on 01/05/19.
//  Copyright © 2019 Christian. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var movieTableView: UITableView!
    private let refreshControl = UIRefreshControl()
    @IBOutlet private var loadingView: UIActivityIndicatorView!
    @IBOutlet private var statusView: UIView!
    @IBOutlet private var statusViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var statusLabel: UILabel!
    
    var movieSearchViewModel = MovieSearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        initViewModel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let query = (searchBar.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if query.count > 0 {
            self.movieSearchViewModel.query = query
        }
    }


}

//MARK:- viewModel related
extension MovieSearchViewController {
    private func initViewModel() {
        movieSearchViewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.movieTableView.reloadData()
            }
        }
        movieSearchViewModel.showStatusViewClosure = { [weak self] (status) in
            DispatchQueue.main.async {
                if let status = status {
                    self?.showStatusView(status)
                } else {
                    self?.hideStatusView()
                }
            }
        }
        movieSearchViewModel.showLoadingViewClosure = { [weak self] (isLoading) in
            DispatchQueue.main.async {
                self?.showLoadingView(isLoading)
            }
        }
        
        movieSearchViewModel.refreshSearchMovie()
    }
}

//MARK:- tableview related
extension MovieSearchViewController: UITableViewDataSource {
    private func initTableView() {
        movieTableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "MovieViewCell")
        
        refreshControl.addTarget(self, action:
            #selector(handleReshresh(_:)),
                                 for: UIControl.Event.valueChanged)
        
        refreshControl.tintColor = UIColor.blue
        movieTableView.addSubview(refreshControl)
    }
    
    
    @objc private func handleReshresh(_ refreshControl: UIRefreshControl?) {
        movieSearchViewModel.refreshSearchMovie()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSearchViewModel.getMoviesCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieViewCell", for: indexPath) as! MovieViewCell
        cell.configureCell(model: movieSearchViewModel.getMovieCellViewModel(at: indexPath.row))
        
        return cell
    }
}

//MARK:- private func
extension MovieSearchViewController {
    private func initView() {
        initTableView()
    }
    
    private func showStatusView(_ status: String) {
        statusLabel.text = status.localized()
        statusViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }) { [weak self] (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                self?.hideStatusView()
            })
        }
    }
    private func hideStatusView() {
        statusViewBottomConstraint.constant = statusView.bounds.height
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    private func showLoadingView(_ isLoading: Bool) {
        if isLoading {
            loadingView.startAnimating()
        } else {
            loadingView.stopAnimating()
            refreshControl.endRefreshing()
        }
    }
}

