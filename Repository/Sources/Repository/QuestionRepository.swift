//
//  QuestionRepository.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/26.
//

import Foundation
import IRepository

public struct QuestionRepository: IQuestionRepository {
    public init() {
        
    }
    
    public func getQuestion() -> String {
        let data = loadData()
        return data.randomElement()?.question ?? ""
    }
    
    private func loadData() ->  [QuestionData] {
        guard let url = Bundle.main.url(forResource: "question", withExtension: "json") else {
            fatalError("ファイルが見つからない")
        }
         
        guard let data = try? Data(contentsOf: url) else {
            fatalError("ファイル読み込みエラー")
        }
         
        let decoder = JSONDecoder()
        guard let questions = try? decoder.decode([QuestionData].self, from: data) else {
            fatalError("JSON読み込みエラー")
        }
        return questions
    }
}

struct QuestionData: Codable {
    let question: String
}
