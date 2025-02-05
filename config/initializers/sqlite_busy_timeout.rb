if ActiveRecord::Base.connection.adapter_name == "SQLite"
    ActiveRecord::Base.connection.execute("PRAGMA busy_timeout = 5000")
  end