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

  def update()
    sql = ("UPDATE customers SET (name, funds) = ('#{@name}', #{@funds} WHERE id = #{@id}")
    SqlRunner.run(sql)
  end

  def films() 
    sql = "SELECT films.* FROM films INNER JOIN tickets ON tickets.film_id = films.id WHERE tickets.customer_id = #{@id};"
    film_hashes = SqlRunner.run(sql)
    result = film_hashes.map {|film_hash| Film.new(film_hash)}
    return result
  end

  # Test method for charging customers below 

  # Look into the RETURNING command in SQL

  def update_funds
      sql = "SELECT films.price, customers.funds FROM films
        INNER JOIN tickets
        ON tickets.film_id = films.id
        INNER JOIN customers
        ON customers.id = tickets.customer_id
        WHERE tickets.customer_id = #{@id};"
      result_hash = SqlRunner.run(sql)[0]
      result = result_hash["funds"].to_i - result_hash["price"].to_i
      return result
  end

  def ticket_count
    sql = "SELECT COUNT (tickets.customer_id) FROM tickets WHERE tickets.customer_id = #{@id};"
    count = SqlRunner.run(sql)[0]
    return count
  end

  # -------- class methods ------

  def self.all() 
    sql = "SELECT * FROM customers;"
    return customer.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    customer_hashes = SqlRunner.run(sql)
    result = customer_hashes.map {|customer_hash| Customer.new(customer_hash)}
    return result
  end




















end