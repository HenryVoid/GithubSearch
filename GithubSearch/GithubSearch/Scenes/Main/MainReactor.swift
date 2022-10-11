//
//  MainReactor.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation
import ReactorKit
import RxDataSources
import RxSwift

final class MainReactor: Reactor {
    public enum Action {
        case viewWillAppear
        case search(keyword: String)
    }
    
    public enum Mutation {
        case updateSections([Main.Section])
        
        case showToast(String?)
        case load(_ on: Bool)
    }
    
    public struct State {
        var sections: [Main.Section] = []
        
        var showToast: String?
        var load: Bool = false
    }
    
    public let initialState: State
    private let useCase: MainUseCaseType
    var disposeBag = DisposeBag()
    
    public init(
        _ useCase: MainUseCaseType
    ) {
        self.useCase = useCase
        let state = State()
        self.initialState = state
    }
}

extension MainReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewWillAppear:
            return self.fetch()
        case .search(let keyword):
            return self.search(keyword: keyword)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .updateSections(let sections):
            newState.sections = sections
        case .showToast(let msg):
            newState.showToast = msg
        case .load(let on):
            newState.load = on
        }
        
        return newState
    }
}

extension MainReactor {
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutation = self.useCase.event.flatMap { event -> Observable<Mutation> in
                switch event {
                case .searchRepos(let repos):
                    return self.responseRepos(repos)
                case .errorMsg(let msg):
                    return self.responseErrorMsg(msg)
                }
            }
        return .merge(mutation, eventMutation)
    }
}


extension MainReactor {
    private func fetch() -> Observable<Mutation> {
        
        self.useCase.execute()
        
        return .empty()
    }
    
    private func search(keyword: String) -> Observable<Mutation> {
        
        self.useCase.search(page: 1, keyword: keyword)
        
        return .empty()
    }
    
    private func responseRepos(_ repos: GitHubSearch.Response) -> Observable<Mutation> {
        let items = repos.items
            .compactMap { Main.Section.Item.searchRepo($0.toGitHubRepoItem()) }
        let section = Main.Section.searchRepo(title: "RxSwift", items: items)
        let sections = [section]
        return .just(.updateSections(sections))
    }
    
    private func responseErrorMsg(_ msg: String) -> Observable<Mutation> {
        return .concat([
            .just(.showToast(msg)),
            .just(.showToast(nil))
        ])
    }
}
