# class Employee
#
#   def initialize(name, salary)
#     @name = name
#     @salary = salary
#   end
#
#   def bonus(multiplier)
#     employee * multiplier
#   end
#
# end
#
# class Manager < Employee
#   def initialize(name, employees)
#     super(name)
#     @employees = employees
#   end
#
#   def bonus(multiplier)
#     sub_salarys = 0
#     @employees.each do |emp|
#       sub_salarys += emp.salary
#     end
#     sub_salarys * multiplier
#   end
#
# end
#
# shawna = Employee.new('shawna', 12,000)
# david = Employee.new('david', 10,000)
# darren = Manager.new('darren', 78,000, [shawna, david])
# darren.bonus
require 'byebug'

class Employee
  attr_reader :salary
  def initialize(name,salary, title, boss)
    @name = name
    @salary = salary
    @title = title
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  def initialize(name, salary, title, boss, employees)
    super(name,salary,title,boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_salaries = 0
    @employees.each do |el|
      
      if el.class == Employee
        total_salaries += el.salary
      else
        total_salaries += el.bonus(multiplier) + el.salary
      end
    end

    total_salaries * multiplier

  end

end
shawna = Employee.new('shawna', 12000, 'TA', "ned")
david = Employee.new('david', 10000, 'TA', "ned")
darren = Manager.new('darren', 78000, 'Manager', "ned" , [shawna, david])
ned = Manager.new('Ned', 1000000, 'VP', nil, [darren])
p ned.bonus(2)
