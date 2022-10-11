//
//  MainUseCase.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation
import RxSwift

enum MainUseCaseEvent {
    case searchRepos(GitHubSearch.Response)
    case errorMsg(String)
}


protocol MainUseCaseType {
    var event: PublishSubject<MainUseCaseEvent> { get }
    
    func execute()
    func search(page: Int, keyword: String)
}

final class MainUseCase: MainUseCaseType {
    
    var event = PublishSubject<MainUseCaseEvent>()
    
    private let gitHubSearchRepository: GitHubSearchRepositoryType
    
    init(
        gitHubSearchRepository: GitHubSearchRepositoryType
    ) {
        self.gitHubSearchRepository = gitHubSearchRepository
    }
    
    func execute() {
        self.searchRepo(page: 1, keyword: "RxSwift")
    }
    
    func search(page: Int, keyword: String) {
        self.searchRepo(page: page, keyword: keyword)
    }
}

extension MainUseCase {
    private func searchRepo(page: Int, keyword: String) {
        self.gitHubSearchRepository
            .search(
                page: page,
                keyword: keyword
            ) { result, error in
                guard let result = result else {
                    self.event.onNext(.errorMsg("호출 에러"))
                    return
                }
                
                self.event.onNext(.searchRepos(result))
            }
    }
}
