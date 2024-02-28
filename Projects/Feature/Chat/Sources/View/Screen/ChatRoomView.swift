//
//  ChatRoomView.swift
//  FeatureChat
//
//  Created by HUNHIE LEE on 2/10/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import SharedDesignSystem
import DomainChatInterface

public final class ChatRoomView: BaseView, InputReceivable {
  public lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout()).then {
    $0.contentInset = .init(top: 52, left: 0, bottom: 0, right: 0)
    $0.scrollIndicatorInsets = .init(top: 52, left: 0, bottom: 0, right: 0)
  }
  
  private lazy var chatInputBar: ChatInputBar = ChatInputBar().then {
    $0.textView.delegate = self
  }
  
  public var inputEventRelay: PublishRelay<MessageContentType> = .init()
  
  private let disposeBag = DisposeBag()
  
  public override func configureUI() {
    addSubview(collectionView)
    addSubview(chatInputBar)
    
    chatInputBar.snp.makeConstraints {
      $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
      $0.horizontalEdges.equalToSuperview()
      $0.height.equalTo(60)
    }
    
    collectionView.snp.makeConstraints {
      $0.top.horizontalEdges.equalToSuperview()
      $0.bottom.equalTo(chatInputBar.snp.top)
    }
  }
  
  public override func bind() {
    collectionView.rx.tapGesture()
      .subscribe(with: self) { owner, gesture in
        owner.endEditing(true)
      }
      .disposed(by: disposeBag)
    
    chatInputBar.inputEventRelay
      .bind(to: inputEventRelay)
      .disposed(by: disposeBag)
  }
  
  private func createLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
      let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
      let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
      let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50))
      let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
      
      let section = NSCollectionLayoutSection(group: group)

      let supplementarySize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
      let supplementaryItem = NSCollectionLayoutSupplementaryItem(layoutSize: supplementarySize, elementKind: UICollectionView.elementKindSectionHeader, containerAnchor: NSCollectionLayoutAnchor(edges: [.top], absoluteOffset: CGPoint(x: 0, y: -50)))
      group.supplementaryItems = [supplementaryItem]
      
      return section
    }
    return layout
  }
}

extension ChatRoomView: UITextViewDelegate {
  public func textViewDidChange(_ textView: UITextView) {
    updateChatInputBarHeight(textView)
    updateSendButtonIsEnabeld(textView)
  }
  
  private func updateChatInputBarHeight(_ textView: UITextView) {
    let newSize = textView.sizeThatFits(CGSize(width: textView.frame.size.width, height: CGFloat.infinity))
    
    let minHeight = 60.0
    let maxHeight = 120.0
    let extraHeight = minHeight - 20
    let newHeight = min(max(newSize.height + extraHeight, minHeight), maxHeight)
    
    if newHeight >= maxHeight {
      chatInputBar.textView.isScrollEnabled = true
    }
    
    chatInputBar.snp.updateConstraints {
      $0.height.equalTo(newHeight)
    }
  }
  
  private func updateSendButtonIsEnabeld(_ textView: UITextView) {
    chatInputBar.updateSendButtonIsEnabled(textView.hasText)
  }
}
