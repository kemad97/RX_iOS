//
//  LangViewController.swift
//  RX_iOS
//
//  Created by Kerolos on 17/05/2025.
//

import UIKit
import RxSwift
import RxCocoa



class UserViewController: UIViewController {
    
    @IBOutlet weak var UsersTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let viewModel : UserViewProtocol = UserViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UsersTableView.delegate = nil
        UsersTableView.dataSource = nil
        UsersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        UsersTableView.allowsSelection = false
        
        
        
        viewModel.users
            .drive(UsersTableView.rx.items(cellIdentifier: "Cell")) { index, user, cell in
                cell.textLabel?.text = user.fullName
            }
            .disposed(by: disposeBag)
        
        viewModel.fetchUsers()

        
        UsersTableView.rx.itemDeleted
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.deleteUser(at: indexPath.row)
            })
            .disposed(by: disposeBag)
        
        replaySubjectInit()
    }
    
    
    func replaySubjectInit() {
        let repSubj = ReplaySubject<Int>.create(bufferSize: 2)
        
        repSubj.onNext(1)
        repSubj.onNext(2)
        repSubj.onNext(3)
        
        repSubj
            .subscribe(onNext: { value in
                print(" recieved: \(value)")
            })
            .disposed(by: disposeBag)
    }
}




