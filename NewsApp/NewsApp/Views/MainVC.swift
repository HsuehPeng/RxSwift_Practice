//
//  ViewController.swift
//  NewsApp
//
//  Created by Hsueh Peng Tseng on 2022/8/30.
//

import UIKit
import RxSwift

class MainVC: UIViewController {
	
	// MARK: - Properties
	
	let disposeBag = DisposeBag()
	
	var articleViewModels = [ArticleViewModel]()
	
	// MARK: - UI Properties
	
	private let tableView: UITableView = {
		let tableView = UITableView()
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseIdentifier)
		return tableView
	}()
	
	// MARK: - LifeCycle

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		setupNavBar()
		setupConstraint()
		
		tableView.dataSource = self
		
		populateNews()
	}
	
	// MARK: - UI
	
	func setupNavBar() {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithDefaultBackground()
		appearance.backgroundColor = .systemCyan
		appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		
		navigationController?.navigationBar.prefersLargeTitles = true
		title = "Top Headlines"
	}
	
	func setupConstraint() {
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
	
	// MARK: - Action
	
	// MARK: - Helpers
	
	private func populateNews() {
		let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=72eced6d616042c292f367a4e8b9ef16")!)
		
		URLRequest.load(resource: resource)
			.subscribe(onNext: { [weak self] articleResponse in
				let articles = articleResponse.articles
				
				articles.forEach { article in
					self?.articleViewModels.append(ArticleViewModel(article))
				}
				
				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
												
			}, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
	}

}

// MARK: - UITableViewDataSource

extension MainVC: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articleViewModels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as? NewsCell else {
			fatalError("Fail to dequeu NewsCell")
		}
		
		cell.articleViewModel = articleViewModels[indexPath.row]
		
		return cell
	}
}

