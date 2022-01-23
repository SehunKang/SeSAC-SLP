//
//  GenderViewController.swift
//  SeSAC-SLP
//
//  Created by Sehun Kang on 2022/01/22.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

class GenderViewController: UIViewController {
    
    static let identifier = "GenderViewController"

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var doneButton: FilledButton!
    @IBOutlet weak var maleView: UIView!
    @IBOutlet weak var femaleView: UIView!
    
    var maleSelected: Bool = false {
        didSet {
            if maleSelected {
                maleView.backgroundColor = CustomColor.SLPWhitegreen.color
                femaleSelected = false
                doneButton.isFakeDisbaled = false
            } else {
                maleView.backgroundColor = .clear
                if !femaleSelected {
                    doneButton.isFakeDisbaled = true
                }
            }
        }
    }
    
    var femaleSelected: Bool = false {
        didSet {
            if femaleSelected {
                femaleView.backgroundColor = CustomColor.SLPWhitegreen.color
                maleSelected = false
                doneButton.isFakeDisbaled = false
            } else {
                femaleView.backgroundColor = .clear
                if !maleSelected {
                    doneButton.isFakeDisbaled = true
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uiConfig()
        bind()
    }
    
    private func uiConfig() {
        guideLabel.text = "성별을 선택해 주세요"
        guideLabel.font = CustomFont.Display1_R20.font
        
        subLabel.font = CustomFont.Title2_R16.font
        subLabel.textColor = CustomColor.SLPGray7.color
        subLabel.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        
        doneButton.setTitleWithFont(text: "다음", font: .Body3_R14)
        doneButton.isFakeDisbaled = true
        
        maleView.layer.cornerRadius = 8
        femaleView.layer.cornerRadius = 8
        
        let maleTapGesture = UITapGestureRecognizer(target: self, action: #selector(maleTap))
        let femaleTapGesture = UITapGestureRecognizer(target: self, action: #selector(femaleTap))
        maleView.addGestureRecognizer(maleTapGesture)
        femaleView.addGestureRecognizer(femaleTapGesture)
    }
    
    private func bind() {
        doneButton.rx.tap
            .subscribe { _ in
                self.doneButtonClicked()
            }
            .disposed(by: disposeBag)
        
    }
    
    @objc func maleTap() {
        maleSelected = !maleSelected
    }
    
    @objc func femaleTap() {
        femaleSelected = !femaleSelected
    }
    
    private func doneButtonClicked() {
        if maleSelected {
            UserDefaultManager.signInData.gender = 1
        } else if femaleSelected {
            UserDefaultManager.signInData.gender = 0
        } else {
            UserDefaultManager.signInData.gender = 2
        }
        
        APIServiceForStart.signIn { statusCode in
            switch statusCode {
            case 200:
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let viewController = sb.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.view.window?.rootViewController = viewController
                self.view.window?.makeKeyAndVisible()
            case 201:
                print("이미가입한 유저??")
            case 202:
                UserDefaultManager.validNickFlag = 1
                let vc = self.storyboard?.instantiateViewController(withIdentifier: NicknameViewController.identifier) as! NicknameViewController
                self.navigationController?.pushViewController(vc, animated: true)
            case 401:
                print("refresh token")
            default:
                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요.")
                
            }
        }
    }
    


}