//
//  NewsResponse.swift
//  NewsApp
//
//  Created by Hsueh Peng Tseng on 2022/8/30.
//

import Foundation

struct ArticleResponse: Codable {
	let articles: [Article]
}

struct Article: Codable {
	let title: String
	let description: String?
}
