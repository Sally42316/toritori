ActiveRecord::Base.connection.execute("PRAGMA busy_timeout = 5000")  # 5秒待機