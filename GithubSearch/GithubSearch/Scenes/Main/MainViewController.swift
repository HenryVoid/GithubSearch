//
//  MainViewController.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import ReactorKit
import Then
import SnapKit

final class MainViewController: UIViewController, View {
    
    typealias Reactor = MainReactor
    typealias DataSource = RxTableViewSectionedReloadDataSource<Main.Section>
    
    // MARK: Properties
    private let tableView = UITableView(frame: .zero).then {
        $0.separatorStyle = .none
        $0.backgroundColor = .clear
        $0.register(MainCell.self, forCellReuseIdentifier: "MainCell")
    }
    
    var disposeBag = DisposeBag()
    
    init(_ reactor: Reactor) {
        super.init(nibName: nil, bundle: nil)
        
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }
}

extension MainViewController {
    // MARK: Layout
    private func configure() {
        self.view.backgroundColor = .white
        
        self.configNavigationBar()
        self.configureSubviews()
        self.configureLayouts()
    }
    
    private func configureSubviews() {
        self.view.addSubview(self.tableView)
    }
    
    private func configureLayouts() {
        self.makeTableViewLayout()
    }
    
    private func configNavigationBar() {
        let titleView = UILabel().then {
            $0.text = "안녕"
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 32, weight: .bold)
        }
        self.navigationItem.titleView = titleView
    }
    
    private func makeTableViewLayout() {
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.left.right.equalTo(self.view)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func configureDataSource() -> DataSource {
        return RxTableViewSectionedReloadDataSource<Main.Section>(
            configureCell: { dataSource, tableView, indexPath, item in
                switch dataSource[indexPath] {
                case .searchRepo(let repo):
                    return self.configureMainCell(repo, indexPath: indexPath)
                }
            }
        )
    }
    
    private func configureMainCell(_ item: Main.GitHubRepoItem, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell else {
            return UITableViewCell()
        }
        cell.bindData(item)
        return cell
    }
}

extension MainViewController {
    // MARK: Bind
    func bind(reactor: Reactor) {
        self.bindAction(reactor)
        self.bindState(reactor)
    }
    
    private func bindAction(_ reactor: Reactor) {
        self.rx.sentMessage(#selector(self.viewWillAppear(_:)))
            .mapToVoid()
            .map { Reactor.Action.viewWillAppear }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.tableView
            .rx.modelSelected(Main.Section.Item.self)
            .asDriver()
            .drive(onNext: self.cellSelected)
            .disposed(by: self.disposeBag)
    }
    
    private func bindState(_ reactor: Reactor) {
        reactor.state
            .map(\.sections)
            .bind(to: self.tableView.rx.items(dataSource: self.configureDataSource()))
            .disposed(by: self.disposeBag)
    }
}

extension MainViewController {
    // MARK: Action
    private func cellSelected(_ model: Main.Section.Item) {
        switch model {
        case .searchRepo(let item):
            guard let url = URL(string: item.url) else { return }
            UIApplication.shared.open(url)
        }
    }
}
