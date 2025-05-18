//
//  UserViewController.swift
//  RX_iOS
//
//  Created by Kerolos on 18/05/2025.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserViewProtocol {
    // Expose Driver for UI binding
    var users: Driver<[User]> { get }
    func fetchUsers()
    func deleteUser(at index: Int)
}

class UserViewModel: UserViewProtocol {
    
    private var userList: [User] = [
        User(fName: "Esraa", lName: "Eid"),
        User(fName: "Mona", lName: "Ahmed"),
        User(fName: "Ahmed", lName: "Essam")
    ]
    
    private let disposeBag = DisposeBag()
    
    private let usersSubject = PublishSubject<[User]>()
    
    
    var users: Driver<[User]> {
        return usersSubject
            .asDriver(onErrorJustReturn: [])
    }
    
    
    func fetchUsers() {
        usersSubject.onNext(userList)
      
        
        Observable.just(())
                   .delay(.seconds(3), scheduler: MainScheduler.instance)
                   .subscribe(onNext: { [weak self] _ in
                       
                       guard let self = self else { return }
                       self.addUser(User(fName: "Ali", lName: "Gamal"))
                   })
                   .disposed(by: disposeBag)
    }
    
    func deleteUser(at index: Int) {
        userList.remove(at: index)
        usersSubject.onNext(userList)
    }
    
    private func addUser(_ user: User) {
        userList.append(user)
        usersSubject.onNext(userList)
    }
}
