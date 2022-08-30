//
//  NewsCell.swift
//  NewsApp
//
//  Created by Hsueh Peng Tseng on 2022/8/30.
//

import UIKit
import RxSwift

class NewsCell: UITableViewCell {
	
	static let reuseIdentifier = "\(NewsCell.self)"

	// MARK: - Properties
	
	let disposeBag = DisposeBag()
	
	var articleViewModel: ArticleViewModel? {
		didSet {
			configureUI()
		}
	}
	
	private let newsTitle: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
		return label
	}()
	
	private let newsContent: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		return label
	}()
	
	// MARK: - Lifecycle
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraint()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - UI
	
	private func setupConstraint() {
		contentView.addSubview(newsTitle)
		contentView.addSubview(newsContent)
		
		NSLayoutConstraint.activate([
			newsTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			newsTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			newsTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
		])
		
		NSLayoutConstraint.activate([
			newsContent.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			newsContent.topAnchor.constraint(equalTo: newsTitle.bottomAnchor, constant: 16),
			newsContent.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			newsContent.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
		])
	}
	
	// MARK: - Helper
	
	private func configureUI() {
		
		articleViewModel?.title.asDriver(onErrorJustReturn: "")
			.drive(self.newsTitle.rx.text)
			.disposed(by: disposeBag)
		
		articleViewModel?.description.asDriver(onErrorJustReturn: "")
			.drive(self.newsContent.rx.text)
			.disposed(by: disposeBag)
	}
	
}
