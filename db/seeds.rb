# # db/seeds.rb

# # ユーザーの作成
# olivia = User.find_or_create_by!(email: "olivia@example.com") do |user|
#     user.name = "Olivia"
#     user.password = "password"
#     user.avatar = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename: "sample-user1.jpg")
# end
  
# james = User.find_or_create_by!(email: "james@example.com") do |user|
#     user.name = "James"
#     user.password = "password"
#     user.avatar = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename: "sample-user2.jpg")
# end
  
# lucas = User.find_or_create_by!(email: "lucas@example.com") do |user|
#     user.name = "Lucas"
#     user.password = "password"
#     user.avatar = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename: "sample-user3.jpg")
# end

# # adminユーザーの作成
# admin = Admin.find_or_create_by(email: "admin@admin.com") do |admin|
#     # パスワード設定は Devise の登録用に必要
#     admin.password = "adminadmin"
#     admin.password_confirmation = "adminadmin"
#   end
  
# # 投稿の作成
# post_1 = Post.find_or_create_by!(user: olivia) do |post|
#     post.text = "可愛い鳥見つけた"
#     post.images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename: "sample-post1.jpg")
# end
  
# post_2 = Post.find_or_create_by!(user: james) do |post|
#     post.text = "これは何の鳥だ？"
#     post.images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename: "sample-post2.jpg")
# end
  
# post_3 = Post.find_or_create_by!(user: lucas) do |post|
#     post.text = "ひな可愛い！"
#     post.images = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename: "sample-post3.jpg")
# end
  
# # グループの作成
# group_1 = Group.find_or_create_by!(name: "セキセイインコを逃がしました", owner_id: olivia.id) do |group|
#     group.detail = "静岡県にてセキセイインコを逃がしました"
# end
  
# group_2 = Group.find_or_create_by!(name: "文鳥を逃がしました", owner_id: james.id) do |group|
#     group.detail = "愛知県にて文鳥を逃がしました"
# end
  
# group_3 = Group.find_or_create_by!(name: "オウムを逃がしました", owner_id: lucas.id) do |group|
#     group.detail = "東京にてオウムを逃がしました"
# end
  
# # グループユーザーの作成（申請中）
# GroupUser.find_or_create_by!(user_id: olivia.id, group_id: group_3.id) do |group_user|
#     group_user.status = :applying # 申請中
# end
  
# GroupUser.find_or_create_by!(user_id: james.id, group_id: group_1.id) do |group_user|
#     group_user.status = :applying # 申請中
# end
  
# GroupUser.find_or_create_by!(user_id: lucas.id, group_id: group_2.id) do |group_user|
#     group_user.status = :approved # 承認済み
# end
  
# # チャットの作成
# Chat.find_or_create_by!(user_id: olivia.id, group_id: group_1.id) do |chat|
#     chat.chat = "可愛い娘を逃しました。。。。助けてください"
# end
  
# Chat.find_or_create_by!(user_id: james.id, group_id: group_2.id) do |chat|
#     chat.chat = "グループは作りましたが、逃がした子を発見しました"
# end
  
# Chat.find_or_create_by!(user_id: lucas.id, group_id: group_3.id) do |chat|
#     chat.chat = "東京都新宿区にてロストです。一緒に探してくれる人募集中です"
# end
  
# # いいねの作成
# Like.find_or_create_by!(user_id: olivia.id, post_id: post_1.id)
# Like.find_or_create_by!(user_id: james.id, post_id: post_2.id)
# Like.find_or_create_by!(user_id: lucas.id, post_id: post_3.id)
  
# # コメントの作成
# Comment.find_or_create_by!(user_id: olivia.id, post_id: post_3.id) do |comment|
#     comment.comment = "可愛い！"
# end
  
# Comment.find_or_create_by!(user_id: james.id, post_id: post_1.id) do |comment|
#     comment.comment = "可愛い！"
# end
  
# Comment.find_or_create_by!(user_id: lucas.id, post_id: post_2.id) do |comment|
#     comment.comment = "可愛い！"
# end
  
# puts "Seed data created successfully."
