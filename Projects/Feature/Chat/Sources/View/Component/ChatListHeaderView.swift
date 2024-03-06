//
//  ChatListHeaderView.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/24/24.
//

import UIKit
import RxSwift
import RxCocoa
import SharedDesignSystem

public final class ChatListHeaderView: BaseControl, Touchable {
  private let chatItem: ChatHeaderItem = ChatHeaderItem(title: "채팅")
  private let historyItem: ChatHeaderItem = ChatHeaderItem(title: "히스토리").then {
    $0.currentState = .unSelected
  }
  
  private var selectedItem: TouchEventType = .chat {
    didSet {
      let items: [TouchEventType: ChatHeaderItem] = [
        .chat: chatItem,
        .history: historyItem
      ]
      items.forEach { type, item in
        item.currentState = type == selectedItem ? .selected : .unSelected
      }
    }
  }
  
  public var touchEventRelay: PublishRelay<TouchEventType> = .init()
  
  public override func configureUI() {
    addSubview(chatItem)
    addSubview(historyItem)
    
    chatItem.snp.makeConstraints {
      $0.verticalEdges.equalToSuperview()
      $0.leading.equalToSuperview()
    }
    
    historyItem.snp.makeConstraints {
      $0.verticalEdges.equalToSuperview()
      $0.leading.equalTo(chatItem.snp.trailing).offset(16)
      $0.trailing.equalToSuperview()
    }
  }
  
  public override func bind() {
    chatItem.touchEventRelay
      .map { .chat }
      .do { [weak self] item in
        print("채팅 눌림")
        self?.selectedItem = item
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
    
    historyItem.touchEventRelay
      .map { .history }
      .do { [weak self] item in
        print("히스토리 눌림")
        self?.selectedItem = item
      }
      .bind(to: touchEventRelay)
      .disposed(by: disposeBag)
  }
  
  public enum TouchEventType {
    case chat
    case history
  }
}
