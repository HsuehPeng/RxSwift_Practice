//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Hsueh Peng Tseng on 2022/8/30.
//

import Foundation
import RxSwift

struct ArticleViewModel {
	let article: Article
	
	init(_ article: Article) {
		self.article = article
	}
	
	var title: Observable<String> {
		return Observable<String>.just(article.title)
	}
	
	var description: Observable<String> {
		return Observable<String>.just(article.description ?? "")
	}
}
