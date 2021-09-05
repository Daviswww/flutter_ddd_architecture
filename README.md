### 前言
身為一個軟體工程師，我們最常見的問題就是變動的需求。而程式碼變更，就會有機會出現不可預期 Bug，有時候已經不是小拇指和食指動一動就可以解決的問題，因此設計模式可以降低程式的債務。本次專案目標就是寫出一個點擊小遊戲。

### Domain Driven Design
這個架構在於每一層都有獨立的事情，我們可以使他們的工作分割得更乾淨，這將帶給程式乾淨、易於測試和閱讀，有的人認為小型團隊使用這種架構只會拖累開發速度，雖然我並不反對，但是壯大後會下定決心更改架構的很少，因為要改成新架構時要投入的時間可能會是好幾倍，有時候幾乎是打掉重練，這就是我想分想給大家的原因。
![](https://raw.githubusercontent.com/Daviswww/triathlon_flutter/master/day17/image/NUHhgax.png)

這次的教學內容可能會有點難，不過我將會帶大家一步步的寫完整個專案，從上圖可以發現流程就跟蓋房子一樣，打地基(Infrastructure)=>把房子建起來(Application)=>裝潢(Presentation)，每個功能都是一棟房子不斷的循環著固定的流程，你的專案就是一座城市。


### 資料夾結構
這是我的簡單創建的資料夾結構，裡面最主要包含了上面所講的application(infrastructure與presentation的橋樑)、presentation(所有場景)、infrastructure(功能)和domain(訊息)清楚的分類著，乾淨的資料夾可以讓你更好找到你需要的檔案，往後的教學都會遵循這個規則創建任何檔案。
```
├── lib
│   ├── application
│   │   ├── auth
│   │   │   ├── auth_bloc.dart
│   │   │   ├── auth_event.dart
│   │   │   └── auth_state.dart
│   │   └── sign_in
│   │       ├── sign_in_bloc.dart
│   │       ├── sign_in_event.dart
│   │       └── sign_in_state.dart
│   ├── config
│   │   └── environment.dart
│   ├── domain
│   │   └── failure.dart
│   ├── infrastructure
│   │   └── auth
│   │       └── auth_repository.dart
│   ├── main.dart
│   └── presentation
│       ├── router
│       │   └── router.dart
│       └── screens
│           ├── home
│           ├── login
│           └── splash
```

### 需要具備的知識
- [基本元件與套件教學](https://github.com/Daviswww/triathlon_flutter)
- [Bloc]()
- [Dartz]()

### 目錄
- [Day17] Flutter - Architecture: Domain Driven Design (part1)
- [Day18] Flutter - Environment (part2)
- [Day19] Flutter - Const: Shared (part3)
- [Day20] Flutter - Theme: Dark mode & Light mode (part4)
- [Day21] Flutter - Presentation AutoRouter (part5)
- [Day22] Flutter - Infrastructure Authentication (part6)
- [Day23] Flutter - Domain Error Handle (part7)
- [Day24] Flutter - Application Login (part8)
- [Day25] Flutter - Application Authentication (part9)
- [Day26] Flutter - Presentation Login & Splash Screen (part10)
- [Day27] Flutter - Infrastructure Click Game (part11)
- [Day28] Flutter - Application Click Game (part12)
- [Day29] Flutter - Presentation Click Game Screen (part13)
- [Day30] Flutter - Flutter App Icon (part14)

### Note:
本次專案會頻繁的使用 Bloc 套件請大家熟悉。

程式碼就跟泥巴球一樣只會越滾越大，乾淨的程式可以降低維護成本。
