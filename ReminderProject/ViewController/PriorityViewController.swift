//
//  PriorityViewController.swift
//  ReminderProject
//
//  Created by 전준영 on 7/3/24.
//

import UIKit
import SnapKit

final class PriorityViewController: BaseViewController {
    
    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["높음", "보통", "낮음"])
        return control
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(sendPriorityNotification), name: NSNotification.Name("sendPriority"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let priority = segmentedControl
            .selectedSegmentIndex != UISegmentedControl.noSegment ? segmentedControl
            .titleForSegment(at: segmentedControl.selectedSegmentIndex) : ""
        NotificationCenter.default.post(name: NSNotification.Name("priorityReceived"), object: nil, userInfo: ["content": priority])
    }
    
    override func configureHierarchy() {
        view.addSubview(segmentedControl)
    }
    
    override func configureLayout() {
        segmentedControl.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        super.configureView()
    }
    
    @objc func sendPriorityNotification(notification: NSNotification) {
        print(#function, notification.userInfo)
        
    }
}
