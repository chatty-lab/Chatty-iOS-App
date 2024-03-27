//
//  ChatMessageCell.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/9/24.
//

import UIKit
import SharedDesignSystem

public class ChatMessageCell: UICollectionViewCell {
  private lazy var profileImageView: UIImageView = UIImageView().then {
    $0.backgroundColor = SystemColor.gray400.uiColor
  }

  private lazy var nicknameLabel: UILabel = UILabel().then {
    $0.font = SystemFont.caption02.font
    $0.textColor = SystemColor.basicBlack.uiColor
  }
  
  public let timeLabel: UILabel = UILabel().then {
    $0.font = SystemFont.caption03.font
    $0.textColor = SystemColor.gray600.uiColor
  }
  
  public let messageView: UIView = UIView()
  
  private var message: ChatMessageViewData?

  public func configureCell(with message: ChatMessageViewData) {
    self.message = message
    setupMessageView(with: message)
  
    timeLabel.text = message.sendTime?.toCustomString(format: .ahhmm)
  }
  
  public override func prepareForReuse() {
    super.prepareForReuse()

    contentView.removeAllSubviews()
    contentView.layoutIfNeeded()
  }
  
  private func setupMessageView(with message: ChatMessageViewData) {
    contentView.addSubview(messageView)
    contentView.addSubview(timeLabel)
    
    switch message.senderType {
    case .currentUser:
      messageView.snp.makeConstraints {
        $0.trailing.equalToSuperview().inset(20)
        $0.top.bottom.equalToSuperview().inset(8)
        $0.width.lessThanOrEqualToSuperview().multipliedBy(0.65)
      }
      
      timeLabel.snp.makeConstraints {
        $0.trailing.equalTo(messageView.snp.leading).offset(-8)
        $0.bottom.equalTo(messageView)
      }
    case .participant(let name):
      setupProfileImageView()
      setupNicknameLabel()
      nicknameLabel.text = name
      
      messageView.snp.makeConstraints {
        $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
        $0.top.equalTo(nicknameLabel.snp.bottom).offset(8)
        $0.bottom.equalToSuperview().offset(-8)
        $0.width.lessThanOrEqualToSuperview().multipliedBy(0.55)
      }
      
      timeLabel.snp.makeConstraints {
        $0.leading.equalTo(messageView.snp.trailing).offset(8)
        $0.bottom.equalTo(messageView)
      }
    }
  }
  
  private func setupProfileImageView() {
    contentView.addSubview(profileImageView)
    profileImageView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(20)
      $0.top.equalToSuperview().offset(8)
      $0.size.equalTo(44)
    }
    profileImageView.makeCircle(with: 44)
  }
  
  private func setupNicknameLabel() {
    contentView.addSubview(nicknameLabel)
    nicknameLabel.snp.makeConstraints {
      $0.leading.equalTo(profileImageView.snp.trailing).offset(10)
      $0.top.equalToSuperview().offset(8)
    }
  }
}
