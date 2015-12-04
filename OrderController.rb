require 'mysql'

class OrderController
  attr_accessor :connection
  def initialize

  end

  def viewOrders(page=nil, offset=nil)

  end

  def viewOrder(id)
    connection = createConnection
    begin
      pst = connection.prepare("SELECT * from orders where id = ?")
      rs = pst.execute id
      id, name, price = rs.fetch
      result = "Id:#{id} Name:#{name} Price:#{price}"
      # puts "#{result}"
    rescue Mysql::Error => er
      puts er
    ensure
      pst.close if pst
      closeConnection
    end
    return result
  end

  private
  def createConnection
    begin
      return Mysql.new 'localhost' , 'wbsrv_usr' , 'pass' , 'wbsrv'
    rescue Mysql::Error => er
      puts er
    end
  end

  def closeConnection
    connection.close if connection
  end

end
