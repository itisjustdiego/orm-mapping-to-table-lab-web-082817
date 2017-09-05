class Student

    attr_accessor :name, :grade
    attr_reader :id
    def initialize(id=nil, name, grade)
        @id = id
        @name = name
        @grade = grade
    end

    def self.create_table

        new_table = <<-SQL
        CREATE TABLE students(
            id INTEGER PRIMARY KEY,
            name CHAR,
            grade INT
        );
        SQL

        DB[:conn].execute(new_table)
    end

    def self.drop_table()
        DB[:conn].execute('DROP TABLE students;')
    end

    def save()

        DB[:conn].execute('INSERT INTO students (name,grade) VALUES (?,?);', self.name, self.grade)

        @id = DB[:conn].execute("SELECT MAX(id) AS id FROM students;")[0][0]

    end

    def self.create(name:, grade:)
        new_student = Student.new(name, grade)
        new_student.save
        new_student
    end
end
