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
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.instance)
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
            
            print("Selected : \(item.element!)")
            
        }.disposed(by: disposeBag)
        
        languageTableView.rx.itemDeleted.subscribe { indexPath in
            
            print("Deleted: \(indexPath.element!.row)")
            
        }.disposed(by: disposeBag)
    }
    
    
}

