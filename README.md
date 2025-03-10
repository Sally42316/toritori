# とりとり　-toritori-

## サイト概要
### サイトテーマ
愛おしくて可愛い鳥を通じてつながるコミュニティサイト
​
### テーマを選んだ理由
もともと鳥（飼育/野鳥）が好きで「X」を通じてイラストや写真、迷子情報を探していました。<br>
Xをメインに検索をかけると関係のない情報も拾ってしまうので、鳥だけでつながるサイトがほしいと思いました。<br>
鳥好きだけが見るサイトとあらかじめ決めてしまえば迷子探索にもユーザーの皆さんは積極的に参加してくれると思います。<br>
また、コミュニティサイトにすることで愛鳥を探しているが、一定の個人情報を保護したいという方の助けにもなると考え、このテーマにしました。
​
### ターゲットユーザ
- 鳥が好きでイラストや写真を眺めていたい人
- 飼い鳥が可愛すぎてとにかく可愛い鳥を発信したい人
- 鳥の絵を描くのが好きでイラストを投稿したい人
- 野鳥を撮影するのが好きで、撮影したものを発表したい人
- 飼い鳥を逃がしてしまい、とにかくボランティアと共に見つけたい人
​
### 主な利用シーン
- 鳥が好きで鳥の写真を見て癒しを得たいとき<br>
- 珍しい野鳥を見つけて、場所や写真を共有したいとき<br>
- 描いた鳥の絵を共有したい時<br>
- 室内飼い鳥を逃がしてしまって、一緒に探す人を募集したい人（コミュニティサイト）
- 同じ鳥種が好きな人ととにかく繋がりたい人（コミュニティサイト）
​
## 設計書
![Image](https://github.com/user-attachments/assets/4ab10d0e-bdc0-4a4b-85b0-c1d9e86cf41e)
![Image](https://github.com/user-attachments/assets/aca23b70-463c-4d5a-a7ab-a5c523baf402)
![Image](https://github.com/user-attachments/assets/45d5afd3-8517-4e91-ab20-a1465bd84a4d)
![Image](https://github.com/user-attachments/assets/9c259109-b655-4a0c-8102-24ca0aa0cf8e)

[toritori_アプリケーション詳細設計書  - 設計書.pdf](https://github.com/user-attachments/files/18814474/toritori_.-.pdf)
​
## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
​
## 使用素材
- フリーイラスト素材として以下を使用<br>
いらすとや(https://www.irasutoya.com/)

## テストデータ（seeds.rb）の利用について
- $ rails db:reset
- 本番環境の場合: $ rails db:seed RAILS_ENV=production
