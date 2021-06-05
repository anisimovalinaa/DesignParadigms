require 'fox16'
require_relative '../Model/employee'
require_relative '../Controller/controller_employee_list'
include Fox

class Window_add_emp < FXMainWindow
  def initialize(app, controller_emp, table)
    @app = app
    @table = table
    @controller_emp = controller_emp
    super(app, "Staff" , :width => 400, :height => 600)
    head = FXLabel.new(self, "Работа отдела кадров\n\nДобавление должности",
                       :opts => JUSTIFY_CENTER_X, :padding => 15)
    head.justify = JUSTIFY_CENTER_X
    head.font =  FXFont.new(app, "Geneva" , 15)

    @main_frame = FXHorizontalFrame.new(self, :padding => 20)
    @frame_names = FXVerticalFrame.new(@main_frame)
    @frame_input = FXVerticalFrame.new(@main_frame)

    FXLabel.new(@frame_names, "ФИО:", :padding => 4)
    @name_emp = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Дата рождения:", :padding => 4)
    @birthday = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Номер телефона:", :padding => 4)
    @phone_number = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Адрес:", :padding => 4)
    @address = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "E-mail:", :padding => 4)
    @e_mail = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Паспорт:", :padding => 4)
    @passport = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Специальность:", :padding => 4)
    @speciality = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Опыт работы:", :padding => 4)
    @work_experience = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Прошлое место работы::", :padding => 4)
    @last_workplace = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Прошлая должность:", :padding => 4)
    @last_post = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Прошлая зарплата", :padding => 4)
    @last_salary = FXTextField.new(@frame_input, 17)

    @name_emp.connect(SEL_COMMAND) do
      unless Employee.fio?(@name_emp.text)
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'ФИО введены неверно'
        )
      end
    end

    @birthday.connect(SEL_COMMAND) do
      unless Employee.date?(@birthday.text)
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Дата введена неверно'
        )
      end
    end

    @phone_number.connect(SEL_COMMAND) do
      unless Employee.phone_number?(@phone_number.text)
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Номер телефона введен не верно'
        )
      end
    end

    @e_mail.connect(SEL_COMMAND) do
      unless Employee.email?(@e_mail.text)
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'E-mail введен не верно'
        )
      end
    end

    @passport.connect(SEL_COMMAND) do
      unless Employee.passport?(@passport.text)
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Паспорт введен не верно'
        )
      end
    end

    @button_save = FXButton.new(@frame_input,
                                "Сохранить",
                                :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
                                :width => 150, :height => 30)

    @button_save.connect(SEL_COMMAND) do
      unless Employee.fio?(@name_emp.text) && Employee.email?(@e_mail.text) &&
        Employee.date?(@birthday.text) && Employee.phone_number?(@phone_number.text) &&
        Employee.passport?(@passport.text)
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Данные введены не верно'
        )
      else
        add
      end
    end

  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def add
    if @work_experience.text.to_i > 0
      @controller_emp.add(@name_emp.text, @birthday.text, @phone_number.text, @address.text,
                               @e_mail.text, @passport.text, @speciality.text, @work_experience.text.to_i,
                               @last_workplace.text, @last_post.text, @last_salary.text)
    else
      @controller_emp.add(@name_emp.text, @birthday.text, @phone_number.text, @address.text,
                               @e_mail.text, @passport.text, @speciality.text, @work_experience.text.to_i)
    end
    @table.appendRows(1)
    @table.setItemText(@table.numRows - 1, 0, @name_emp.text)
    @table.setItemText(@table.numRows - 1, 1, @birthday.text)
    @table.setItemText(@table.numRows - 1, 2, @phone_number.text)
    @table.setItemText(@table.numRows - 1, 3, @address.text)
    @table.setItemText(@table.numRows - 1, 4, @e_mail.text)
    @table.setItemText(@table.numRows - 1, 5, @passport.text)
    @table.setItemText(@table.numRows - 1, 6, @speciality.text)
    @table.setItemText(@table.numRows - 1, 7, @work_experience.text)
    @table.setItemText(@table.numRows - 1, 8, @last_workplace.text)
    @table.setItemText(@table.numRows - 1, 9, @last_post.text)
    @table.setItemText(@table.numRows - 1, 10, @last_salary.text)
    @table.visibleRows += 1
    self.close
  end
end