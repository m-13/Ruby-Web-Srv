  require 'mysql'

  class OrderController

    def viewOrders(par = nil)
      # puts "#{par}"
      result = ""
      error = false
      if par.empty?
        # puts "Empty"
        ordersQuery = "SELECT * from orders ORDER BY id"
      else
        page = nil
        no = nil
        page = par["page"].to_i unless par["page"].nil?
        no = par["no"].to_i unless par["no"].nil?
        if(no.nil?)
          no = 10
        end
        if(page.nil?)
          page = 1
        end
        # puts "#{page} #{no} before start"
        start = (10*(page-1))
        # puts "#{start}"
        range = start + no
        # puts "#{range}"
        ordersQuery = "SELECT * from orders ORDER BY id LIMIT #{start} , #{range}"
        # puts "#{ordersQuery}"
      end
      connection  = createConnection
      # puts connection.get_server_info
      begin
        rs = connection.query ordersQuery
        # puts "#{rs}"
        rs.each do |row|
          result = result + "#{row[0]} #{row[1]} #{row[2]}\n"
        end
      rescue Mysql::Error => er
        puts er.error
      ensure
        connection.close if connection
      end
      if error
        return "Error in URL"
      else
        return result
      end
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
  end
