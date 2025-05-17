//
//  LangViewController.swift
//  RX_iOS
//
//  Created by Kerolos on 17/05/2025.
//

import UIKit
import RxSwift
import RxCocoa

class LangViewController: UIViewController {
    
    @IBOutlet weak var languageTableView: UITableView!
    
    private let disposeBag = DisposeBag()
    
    let languages = Observable.of(["Arabic", "English", "German", "French"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languages
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .bind(to: languageTableView.rx.items(
                cellIdentifier: "Cell",
                cellType: CustomTableViewCell.self
            )) { row, item, cell in
                cell.langLabel.text = item
            }
            .disposed(by: disposeBag)
        
        languageTableView.rx.itemSelected.subscribe { indexPath in
            print("Section: \(indexPath.element!.section), Row: \(indexPath.element!.row)")
        }.disposed(by: disposeBag)
        
        languageTableView.rx.modelSelected(String.self).subscribe { item in
            print("Selected language: \(item.element!)")
        }.disposed(by: disposeBag)
        
        languageTableView.rx.itemDeleted.subscribe { indexPath in
            print("Deleted item at row: \(indexPath.element!.row)")
        }.disposed(by: disposeBag)
    }
    
    
}

