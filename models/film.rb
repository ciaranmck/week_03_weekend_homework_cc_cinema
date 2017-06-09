require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def self.all()
    sql = "SELECT * FROM films"
    return film.map_items(sql)
  end

  def delete_all()
    sql = "DELETE * FROM films"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    film_hashes = SqlRunner.run(sql)
    result = film_hashes.map {|film_hash| Film.new(film_hash)}
    return result
  end


















end