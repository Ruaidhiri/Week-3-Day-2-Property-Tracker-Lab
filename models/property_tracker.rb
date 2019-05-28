require('pg')
require('pry-byebug')

class PropertyTracker

attr_accessor :address, :value, :number_of_bedrooms, :buy_let_status
# attr_reader :id

  def initialize(options)
      @address = options['address']
      @value = options['value'].to_i
      @number_of_bedrooms = options['number_of_bedrooms'].to_i
      @buy_let_status = options['buy_let_status']
      @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "
    INSERT INTO properties
    (
      address, value, number_of_bedrooms, buy_let_status
    ) VALUES ($1, $2, $3, $4) RETURNING *
    "
    values = [@address, @value, @number_of_bedrooms, @buy_let_status]

    db.prepare("save", sql)
    save_property = db.exec_prepared("save", values)

    save_property_hash = save_property[0]
    @id = save_property_hash['id'].to_i
    db.close()
  end

  def PropertyTracker.all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close
    return properties.map{|property| PropertyTracker.new(property)}
  end


  def update()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "UPDATE properties SET
    (
      address,
      value,
      number_of_bedrooms,
      buy_let_status
      ) = (
        $1, $2, $3, $4
        ) WHERE id = $5"
        values = [@address, @value, @number_of_bedrooms, @buy_let_status, @id]
        db.prepare('update', sql)
        db.exec_prepared('update', values)
        db.close
  end

  def delete()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_1", sql)
    db.exec_prepared("delete_1", values)
    db.close()
  end

  def PropertyTracker.find(id)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id]
    db.prepare("find_1", sql)
    result = db.exec_prepared("find_1", values)
    db.close()
    return result
  end


  def PropertyTracker.find_by_address(address)
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1"
    values = [address]
    db.prepare("find_1", sql)
    result = db.exec_prepared("find_1", values)
    db.close()
    result_hash = result[0]
    property = PropertyTracker.new(result_hash)
    return property
  end

end
