  require 'mysql'

  class OrderController

    def viewOrders(param = nil)
      par = to_hash(param)
      result = ""
      if par.empty?
        ordersQuery = "SELECT * from orders ORDER BY id"
      else
        page = (par["page"] || 1).to_i
        no = (par["no"] || 10).to_i
        start = (10*(page-1))
        range = start + no
        ordersQuery = "SELECT * from orders ORDER BY id LIMIT #{start} , #{range}"
      end
      connection  = createConnection
      begin
        rs = connection.query ordersQuery
        rs.each do |row|
          result = result + "#{row[0]} #{row[1]} #{row[2]}\n"
        end
      rescue Mysql::Error => er
        puts er.error
      ensure
        connection.close if connection
      end
      return result
    end

    def viewOrder(id)
      connection = createConnection
      begin
        orderQuery = "SELECT * from orders where id = ?"
        pst = connection.prepare orderQuery
        rs = pst.execute id
        id, name, price = rs.fetch
        result = "Id:#{id} Name:#{name} Price:#{price}"
      rescue Mysql::Error => er
        puts er
      ensure
        pst.close if pst
        connection.close if connection
      end
      return result
    end

    private
    def createConnection
      begin
        return Mysql.new 'localhost' , 'wbsrv_usr' , 'pass' , 'wbsrv'
      rescue Mysql::Error => er
        puts er
        return nil
      end
    end

    def to_hash(param)
      params = Hash.new
      unless param.nil?
        p = param.split("&")
        p.each do |element|
          e = element.split("=")
          params[e[0]] = e[1]
        end
      end
      return params
    end
  end
