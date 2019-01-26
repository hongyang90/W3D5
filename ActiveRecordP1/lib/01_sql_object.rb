require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject 
  
  def self.columns
   
    # ...
    a ||= DBConnection.execute2(<<-SQL)
    Select 
      *
    from
      #{self.table_name}
    
    SQL
   @columns =  a.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|

        define_method(col) do
         self.instance_variable_get("@#{col}")
         @attributes["@#{col}"]
        end

        define_method("#{col}=") do |val|
         self.instance_variable_set("@#{col}", val)
         @attributes["@#{col}"] = val
        end

     
    end 
       

  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name

  end

  def self.table_name
    # ...
    @table_name ||= self.to_s.tableize

  end

  def self.all
    # ...
  

  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...
    params.keys.map(&:to_sym).each do |key|
      raise "Error" if !self.columns.include?(key)
    end 
  end

  def attributes
    # ...
    @attributes = {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
