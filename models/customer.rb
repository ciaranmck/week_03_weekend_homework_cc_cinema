require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize( 
    options)
  @id = options['id'].to_i if options['id']
  @name = options['name']
  @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ('#{@name}', '#{@funds}') RETURNING id"
    customer = SqlRunner.run(sql).first
    @id = customer['id'].to_i
  end

  def films() 
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = {@id};"
    film_hashes = SqlRunner.run(sql)
    result = film_hashes.map {|film_hash| Film.new(film_hash)}
    return result
  end

  # -------- class methods ------

  def self.all() 
    sql = "SELECT * FROM customers"
    return customer.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE * FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    customer_hashes = SqlRunner.run(sql)
    result = customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
    return result
  end




















end