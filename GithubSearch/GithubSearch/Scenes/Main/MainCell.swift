//
//  MainCell.swift
//  GithubSearch
//
//  Created by 송형욱 on 2022/10/10.
//

import Foundation
import UIKit

final class MainCell: UITableViewCell {
    private let rootView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    private let titleLabel = UILabel().then {
        $0.text = ""
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configure()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension MainCell {
    // MARK: Layout
    private func configure() {
        self.contentView.backgroundColor = .clear
        self.configureSubviews()
        self.configureLayout()
    }
    
    private func configureSubviews() {
        self.contentView.addSubview(self.rootView)
        self.rootView.addSubview(self.titleLabel)
    }
    
    private func configureLayout() {
        self.makeRootViewLayout()
        self.makeTitleLabelLayout()
    }
    
    private func makeRootViewLayout() {
        self.rootView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView)
            make.left.equalTo(self.contentView).offset(8)
            make.right.equalTo(self.contentView).offset(-8)
            make.bottom.equalTo(self.contentView)
        }
    }
    
    private func makeTitleLabelLayout() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.rootView).offset(16)
            make.left.equalTo(self.rootView).offset(14)
            make.right.equalTo(self.rootView).offset(-14)
            make.bottom.equalTo(self.rootView).offset(-16)
        }
    }
}

extension MainCell {
    func bindData(_ item: Main.GitHubRepoItem) {
        self.titleLabel.text = item.fullName
    }
}
