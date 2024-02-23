//
//  MovieListViewController.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import UIKit

class MovieListViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var isFirstTimeLoaded = true
    var viewModel : MovieListViewModel!
    let identifier = MovieListTableViewCell.className
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isFirstTimeLoaded {
            isFirstTimeLoaded = false
            view.layoutIfNeeded()
            setupViews()
        }
    }
    
    private func setViewModel() {
        let service = MovieService()
        let imageDownloadService = ImageDownloadService()
        viewModel = MovieListViewModel(movieService: service, imageDownloadService: imageDownloadService)
    }
    
    private func setupViews() {
        setupTableView()
        showDefaultQueryItems()
        setupSearchbar()
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: MovieListTableViewCell.className, bundle: nil)
        nib.instantiate(withOwner: self)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }
    
    private func showDefaultQueryItems() {
        viewModel.setNewMovieItems(query: "marvel") { isSuccess in
            guard isSuccess else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupSearchbar() {
        searchBar.delegate = self
    }

}

extension MovieListViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }
}

extension MovieListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? MovieListTableViewCell, let movieInfo = viewModel.getItemAt(at: indexPath.row) else {
            return UITableViewCell()
        }
        cell.layoutIfNeeded()
        cell.titleLabel.text = movieInfo.title
        cell.overviewLabel.text = movieInfo.overview
        let posterURL = viewModel.getPosterURL(path: movieInfo.posterPath)
        let currentIndex = indexPath.row
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.viewModel.getPosterImage(url: posterURL) { image in
                let finalImage = image ?? UIImage(named: "NoImage")
                DispatchQueue.main.async {
                    if currentIndex == indexPath.row {
                        cell.posterImageView.image = finalImage
                    }
                }
            }
        }
        return cell
    }
    
}

extension MovieListViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        searchBar.endEditing(true)
        guard let query = text, !query.isEmpty else {
            return
        }
        viewModel.setNewMovieItems(query: query) { isSuccess in
            guard isSuccess else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
