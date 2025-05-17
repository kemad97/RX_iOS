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
    
    @IBOutlet weak var debounceLabel: UILabel!
    
    @IBOutlet weak var throttleLabel: UILabel!
    
    @IBOutlet weak var btnThrottle: UIButton!
    @IBOutlet weak var btnDebounce: UIButton!
    
    private let disposeBag = DisposeBag()
    private var debounceCounter = 0
    private var throttleCounter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        debounceLabel.text = "0"
        throttleLabel.text = "0"
        
        btnDebounce.rx.tap
            .debounce(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.debounceCounter += 1
                self.debounceLabel.text = " \(self.debounceCounter)"
                
            }).disposed (by : disposeBag)
        
           
        
        btnThrottle.rx.tap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.throttleCounter += 1
                self.throttleLabel.text = " \(self.throttleCounter)"
            }).disposed(by: disposeBag)
            
        
        Observable.from ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
            .map { $0 * 5 }
            .filter { $0 % 2 == 0 }
            .skip(2)
            .take(10)
            .subscribe(onNext: { value in
                print(value)
            })
            .disposed(by: disposeBag)
    }
    
}



