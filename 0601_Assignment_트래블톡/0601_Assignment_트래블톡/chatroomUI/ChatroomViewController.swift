//
//  ChatroomViewController.swift
//  0601_Assignment_트래블톡
//
//  Created by 김성률 on 6/1/24.
//

import UIKit

class ChatroomViewController: UIViewController {

    var chat: ChatRoom?
    let placeholder = "메세지를 입력하세요"
    
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var chatTextView: UITextView!
    @IBOutlet var textFieldUI: UIView!
    @IBOutlet var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let chat = chat else { return }

        configureChatroomViewController(transition: chat)
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTextView.delegate = self
        
        DispatchQueue.main.async {
            let index = IndexPath(row: chat.chatList.count - 1, section: 0)
            self.chatTableView.scrollToRow(at: index, at: .bottom, animated: false)
        }
        
        sendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        
    }
    
}

extension ChatroomViewController {
    
    func configureChatroomViewController(transition: ChatRoom) {
        
        navigationItem.title = transition.chatroomName
        
        let backButtonImage = UIImage(systemName: "chevron.backward")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonClicked))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        chatTableView.separatorStyle = .none
        chatTableView.rowHeight = UITableView.automaticDimension
        
        chatTextView.text = placeholder
        chatTextView.textColor = .lightGray
        chatTextView.backgroundColor = .systemGray6
        
        textFieldUI.backgroundColor = .systemGray6
        textFieldUI.layer.cornerRadius = 7
        
        let userXib = UINib(nibName: UserTableViewCell.identifier, bundle: nil)
        chatTableView.register(userXib, forCellReuseIdentifier: UserTableViewCell.identifier)
        
        let otherXib = UINib(nibName: otherTableViewCell.identifier, bundle: nil)
        chatTableView.register(otherXib, forCellReuseIdentifier: otherTableViewCell.identifier)
        
    }
    
    @objc func backButtonClicked() {
        
        navigationController?.popViewController(animated: true)
            
    }
    
    @objc func sendButtonClicked(sender: UIButton) {
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let formattedDate = dateFormatter.string(from: currentDate)
        
        if chatTextView.text != "" {
            chat?.chatList.append(Chat(user: .user, date: formattedDate, message: chatTextView.text!))
            
        }
        
        chatTableView.reloadData()
        chatTextView.text = nil
    }
    
}

extension ChatroomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chat!.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if chat?.chatList[indexPath.row].user == .user {
            
            let cell = chatTableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as! UserTableViewCell
            
            cell.configureUserTableViewCell(transition: chat!, index: indexPath.row)
            
            return cell
            
        } else {

            let cell = chatTableView.dequeueReusableCell(withIdentifier: otherTableViewCell.identifier) as! otherTableViewCell
            
            cell.configureOtherTableViewCell(transition: chat!, index: indexPath.row)
            
            return cell
        }
        
    }
    
}

extension ChatroomViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if chatTextView.textColor == .lightGray {
            chatTextView.text = nil
            chatTextView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if chatTextView.text.isEmpty {
            chatTextView.text = placeholder
            chatTextView.textColor = .lightGray
        }
        
    }
    
}
