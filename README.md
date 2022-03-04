# SeSAC-SLP
[![SLP 사용 영상](https://img.youtube.com/vi/diW0eipo-q8/sddefault.jpg)](https://youtu.be/diW0eipo-q8)  
*클릭하면 유튜브 동영상으로 재생됩니다.*


## 프로젝트 개요
사용자의 위치를 기반으로, 취미가 같은 친구를 찾을 수 있는 애플리케이션을 실 서비스를 진행 할 수 있는 완성도로 만드는 프로젝트입니다.


## 프로젝트 기간 : 2021. 01. 17 ~ 2021. 02. 26


## 프로젝트 진행 방식
애플리케이션의 디자인, 기획, 백엔드 서버가 준비된 상태에서 각각의 디자인과 기획에 맞는 아키텍쳐와 기능을 스스로 찾아 구현하는 식으로 진행했습니다.
애플리케이션은 전적으로 개인이 구현하지만 4인 구성의 팀을 구성하여 매일 3회 데일리 스크럼을 통해 사용 기술 및 진행상황 공유, 계획 수립, 회고를 진행하였습니다.

## 사용 기술 스택
MVVM, RxSwift, RxCocoa, Moya, Realm, StoreKit, MapKit, FirebaseAuth, FirebaseCloudMessaging ,Core Location, UserNotification ,SkeletonView, Toast-Swift, SnapKit, TabMan, RangeSeekSlider, ModernCollectionView

## 상세 리뷰

### 회원가입

<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556561-a3b2ee8d-cef4-4f7b-b7b3-c01cd9bc1cc1.PNG"> |
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556596-f4ebf9ad-87b8-4895-b0e0-aee6293300ca.PNG"> |
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556593-f497ef77-9c69-4ffa-86b1-4fb8695add92.PNG">

회원가입의 경우 모든 뷰를 MVVM 아키텍쳐와 RxSwift의 Input/Output 구조를 사용하여 구현하였다. 모든 텍스트 필드와 버튼은 커스텀 클래스를 만들어 디자인에 맞게 모듈화를 했다.  
텍스트 필드는 editing의 여부와 user interaction의 success, error에 따라 설정이 바뀔 수 있게하였다. 커스텀 버튼의 경우 UIbutton configuration과 UIControl.State의 값들을 각각 설정하여 커스텀 클래스를 구현했다.
전화번호, 이메일의 경우 String struct의 Extension을 통해 정규표현식을 활용하여 유효성 검사를 하였다.  
성별 선택화면의 경우 성별을 선택하지 않아도 회원가입 진행이 되는데 이는 남/여 성별만 선택 가능할 경우 앱스토어 심사에서 리젝되는 이슈가 있기 떄문이다. 그러나 추후 성별 선택 없이 친구찾기를 진행 할 경우 회원정보 변경을 필요로 하게 하는 식으로 로직이 설정된다. 해당 프로젝트가 Service Level Project로 명명되는 납득할만한 로직중 하나라고 생각한다.

### 홈

<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556607-48f853d1-8b86-4eb4-94cb-1c699a01d918.PNG"> |
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556653-df03d5a4-3900-4819-a218-c06a7cf86a5a.PNG"> 

CLLocationManager를 통해 사용자의 위치권한을 확인한다. MapView의 기본, 최대, 최소 축척을 설정하여 최대한 사용하기 편한 지도를 만들었다. 사용자가 맵을 움직일때 마다 서버와 통신하여 지도 기준 친구를 찾고있는 친구들을 CustomAnnotation으로 보여준다. 이때 좌측 상단의 스위치를 통해 친구의 성별을 설정할 수 있다.  
우측 하단의 플로팅 버튼을 통해 친구를 찾을 수 있는데 사용자의 상태에 따라(Default, 친구를 찾는 중, 매칭 완료) 플로팅 버튼의 이미지와 클릭하였을 때 이동하는 뷰가 다르다. UserDefaults의 값을 RxSwift를 활용 Observe 하는 방식으로 플로팅버튼의 설정을 비동기로 처리한다. 
프로젝트의 DB는 Realm을 사용한 채팅을 제외하고 전부 UserDefaults가 사용되었다. 저장이 필요한 데이터의 양이 많지 않고 Property Wrapper를 학습하기 위해서였다. 모든 UserDefaults는 Property Wrapper로 사용성을 높였다. Struct까지 이를 적용한 점이 특히 편했다.  

### 친구 찾기

<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556621-525ae028-4d23-4ee4-90b7-8fb92cf84422.PNG"> | 
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556638-d9e71fe5-9006-4163-ac9b-531e13b724b1.PNG"> |
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556635-a76fef96-9d76-45bd-90fa-697abf3f047f.PNG"> 

사용되는 모든 CollectionView는 DiffableDataSource와 SnapShot, CompositionalLayout이 사용된 ModernCollectionView를 적용하였다. 이를 학습하며 Expandable한 카드뷰에 적용하느라 프로젝트 첫 두번째 주 한주를 통째로 사용했다. 계획했던 것보다 훨씬 많은 시간을 쓰는 바람에 마음이 급해져 회원가입이 끝난후 부터 아키텍쳐를 전혀 신경쓰지 못한 채 구현과 기술 사용에 급급한 프로젝트가 되어버린것 같아 아쉽다. 사실 ModernCollectionView 자체는 학습에 오랜 시간이 필요한 내용이 아니라고 생각한다. 그러나 이를 각각의 셀이 컬렉션뷰인 컬렉션뷰로 만들다 보니 레이아웃이 잡히고, 데이터가 입력되는 주기에 맞춰 동적인 레이아웃이 설정되게 하는것이 내겐 어려운 지점이었다. 결과적으로는 원하는 카드뷰를 구현하긴 했지만 레이아웃 오류가 조금은 있는 상태에서 타협한 채로 프로젝트를 이어서 진행했다. ModernCollectionView를 학습하며 WWDC, 스택오버플로우, 블로그 등등 도움이 많이 되었지만 가장 도움이 되었던 건 Apple 문서의 예제 프로그램이었다.  

### 인앱 구매
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556643-65181055-4e6c-4bc1-9fad-484e3a9c27b3.PNG"> | 
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156589678-6d88ab01-c3ec-4e11-bf08-e49a2d0421ee.PNG"> | 
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156589639-a244c4d4-a3bd-4520-898c-07437d9d92ae.PNG"> 

StoreKit을 사용한 인앱 구매 화면이다. 앱스토어뿐 아니라 서버와의 Receipt Validation이 진행된다. 앱스토어로부터 프로덕트를 불러오는 시간이 생각보다 오래 걸려서 기획에는 없던 내용이지만 SkeletonView를 적용하였다.   
새싹찾기 뷰와 스토어 모두 TabMan 라이브러리를 활용하여 뷰컨트롤러를 전환하는 식으로 구현했다.

### Push Notification

<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556653-df03d5a4-3900-4819-a218-c06a7cf86a5a.PNG"> |
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556666-0d4e8547-5707-4016-b105-9a20527953d2.PNG"> 

친구 찾기를 걸어놓고 상대방이 나에게 요청을 할 때, 내가 상대에게 요청을 하고 상대가 수락을 할 때, 매칭이 된 이후 채팅이 올 때 각각 서버로부터 Push Notification이 온다.  
푸쉬를 클릭 했을 때 애플리케이션이 백그라운드 상태 일 경우와 사용중인 경우, 사용중일 경우 현재 위치해 있는 뷰에 따라, 그리고 상대와 나의 매칭 상태에 따라 각각의 푸쉬에 맞는 화면으로 전환해 준다.
현재 탑뷰를 구하는 메서드, 루트뷰를 구하는 메서드, 그리고 뷰를 푸쉬하면서 네비게이션 스택에 뷰들을 넣어주는 식으로 뷰를 자연스럽게 전환 했다.  
요청 푸쉬를 받은 후 새싹찾기뷰에서 '받은요청' 탭으로 넘어가는 부분에서 Tabman에 마땅한 메서드가 없어서 헤맸는데 isPushed 라는 프로퍼티를 플래그로 설정하여 defaultPage를 결정하는 방식으로 간단하게 해결했다.

### 채팅

<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556668-f6574c00-bfef-40ab-8988-904822a7b5c0.PNG"> |
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556670-75ebff6e-2621-462f-9526-5538f66039ce.PNG"> |
<img width="30%" src="https://user-images.githubusercontent.com/79244795/156556673-7c86e228-e6a3-4f9f-9f94-ebc9ea952e7b.PNG">

채팅이 시작되면 상대와의 대화를 Realm을 통해 불러오고 DB에 저장된 마지막 대화 이후의 대화를 서버로부터 받아온다. Socket.IO 라이브러리를 사용하여 실시간 소켓통신으로 채팅이 진행되며 모든 주고받는 채팅은 DB에 저장 된 후 뷰로 불러온다. Realm의 Notification token을 사용하여 구현했다.  
우측 상단의 ellipsis 버튼을 클릭했을 때 카카오톡의 새로운 채팅 버튼을 클릭할 때 처럼 만들고 싶었다. 마땅한 라이브러리나 레퍼런스가 없어 무식하게 접근했다. 버튼목록의 y값에 CGAffineTransform을 통해 -200을 줘서 화면 위로 보내놓고 ellipsis 버튼을 클릭하면 origin으로 복귀 시키는 식으로 구현했다.


## 회고

프로젝트 초반 스케줄이 엉키면서 급한 마음에 좀더 고민하며 코드를 작성하지 못한 것 같아 아쉽다. 그래도 지금까지 진행한 프로젝트 중에 가장 규모가 큰 프로젝트였고 배운게 정말 많은 프로젝트였다.  
기술적으로 가장 많이 배운 점은, 백엔드 서버와의 통신을 하며 생길 수 있는 다양한 변수들을 어떻게 사용자 경험을 고려하여 해결할수 있을까? 하는 점.  
기술 외적으로 느낀바가 큰 점은, 한달이 넘는 기간을 평일주말 할것없이 매일 밥먹는 시간을 제외하고 모든 시간을 프로젝트를 진행하는데 썼던것 같은데, 시간을 굉장히 비효율적으로 무작정 썼다는 점. 과정 정리가 되면 이 부분에 대한 고민을 진지하게 해 볼 예정이다.

