require_relative('../db/sql_runner')

class Ticket

  attr_reader :id 
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ('#{@customer_id}', '#{@film_id}') RETURNING id"
    ticket = SqlRunner.run(sql).first
    @id = ticket['id'].to_i
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = #{@customer_id}"
    customer_hash = SqlRunner.run(sql).first()
    return Customer.new(customer_hash)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = #{@film_id}"
    film_hash = SqlRunner.run(sql).first()
    return Film.new(film_hash)
  end

  # -------- class methods ------

  def self.all()
    sql = "SELECT * FROM tickets"
    return ticket.map_items(sql)
  end

  def delete_all()
    sql = "DELETE * FROM tickets"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    ticket_hashes = SqlRunner.run(sql)
    result = ticket_hashes.map {|ticket_hash| Ticket.new(ticket_hash)}
    return result 
  end























end