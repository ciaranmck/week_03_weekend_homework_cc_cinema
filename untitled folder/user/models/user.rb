require_relative('../db/sql_runner.rb')

class User
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def self.delete_all
    sql = "Delete from users;"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "Select * from users;"
    user_hashes = SqlRunner.run(sql)
    user_objects = user_hashes.map { |user_hash| User.new(user_hash) }
    return user_objects
  end

  def save
    sql = "INSERT INTO users (name) VALUES ('#{@name}') RETURNING *;"
    returned_array = SqlRunner.run(sql)
    user_hash = returned_array[0]
    @id = user_hash['id'].to_i
  end
end