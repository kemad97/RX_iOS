//
//  ViewController.swift
//  RX_iOS
//
//  Created by Kerolos on 16/05/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var label: UILabel!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        label.text = switchControl.isOn ? "ON" : "OFF"
        
        switchControl.rx.isOn
                .subscribe(onNext: { [weak self] isOn in
                    self?.label.text = isOn ? "ON" : "OFF"
                })
                .disposed(by: disposeBag)
        }


}

