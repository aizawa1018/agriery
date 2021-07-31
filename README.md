# README

# Agriery
Qiitaをイメージした農業のインプット、アウトプットに特化したアプリケーション

# 概要
### 考えや価値観を共有し自身の成長を促す

農業の最新情報や農場の問題点を解決するには、
・講習会に参加
・専門誌を読み勉強する
・関係団体（農協、NOSAI）、近隣の農家に相談する
など、おおまかにこの３つがあります。
講習会や本から得た情報をどう活かすか人それぞれあります。
それらの思想をインプット、アウトプットをし、さらにはアクションプランも共有することで講習会や本だけでは得られない価値をユーザー同士で共有しあえます。
価値観を広げることで新たな挑戦の機会を得たり、 苦手だったものを克服できるきっかけにもなり、自分自身の成長にも繋がります。

# Agriery URL
 デプロイ後にURLを貼る
 
 # 利用方法
 　　・トップページから新規登録・ログイン
 　　・一覧画面から遷移
 　　・新規投稿は右上の投稿をクリック、タイトル、内容、タグを記入後投稿する
 　　・投稿後は一覧に戻る
 
 完成後動画で説明
 
 
 # 目指した課題解決
 自身が持っている課題を解決するため取り組んだことを記入し苦労したこと、新たな問題点、結果をアウトプットを行い他のユーザーに情報共有したり助言をできるようにしました。
 
#機能一覧

| 　　　　　　　　　　　　　　機能   　　　　  | 　　　　　　　　　　　　　　　　　　　概要　　　　　　　　　　  　　　　　　　　　　　 　　　　| 
|　ユーザー管理機能　　　　　　　　　　| 新規登録・ログイン・ログアウトが可能 　　|
|　投稿機能          　　 | 記事の投稿が可能 　　　　　　　　　　　　　　　　　　　　　　　　　　|
|　投稿詳細機能        | 各投稿詳細が詳細ページで閲覧可能　　　|　
|　投稿編集・削除機能	　　　　 | 投稿者本人のみ投稿編集・削除が可能|
|　ユーザー詳細表示機能　　　| 投稿一覧が閲覧可能　　　　　　　　　　　　　　　　　　　　　　　　　|
| コメント機能	　　　　　　　　 | 投稿詳細ページからコメントが可能　　　　 |

#使用言語
・Ruby
・Ruby on Rails
・HTML/CSS
・SQL


## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |

### Association

- has_many :posts
- has_many :comments

## tags テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :post_tag_relations
- has_many :posts, through: :post_tag_relations

## post_tag_relations テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| post   | references | null: false, foreign_key: true |
| tag    | references | null: false, foreign_key: true |

### Association

- belongs_to :post
- belongs_to :tag

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| post    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :post

## posts テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| title   | string     | null: false                    |
| text    | text       | null: false                    |
| user    | references | null: false, foreign_key: true |

### Association

- has_many :post_tag_relations
- has_many :tags, through: :post_tag_relations
- has_many :comment
- belongs_to :user


