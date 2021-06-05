require 'fox16'
include Fox

class Window_add_post < FXMainWindow
  def initialize(app, controller_instance, table)
    @app = app
    @table = table
    @controller_instance = controller_instance
    super(app, "Staff" , :width => 400, :height => 400)
    head = FXLabel.new(self, "Работа отдела кадров\n\nДобавление должности",
               :opts => JUSTIFY_CENTER_X, :padding => 15)
    head.justify = JUSTIFY_CENTER_X
    head.font =  FXFont.new(app, "Geneva" , 15)

    @main_frame = FXHorizontalFrame.new(self, :padding => 20)
    @frame_names = FXVerticalFrame.new(@main_frame)
    @frame_input = FXVerticalFrame.new(@main_frame)

    FXLabel.new(@frame_names, "Название должности:", :padding => 4)
    @name_post = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Фиксированная зарплата:", :padding => 4)
    @fixed_salary = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Ежемесячная премия:", :padding => 4)
    @premium_salary = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Ежеквартальная премия:", :padding => 4)
    @quarterly_award = FXTextField.new(@frame_input, 17)
    FXLabel.new(@frame_names, "Бонусы(в процентах):", :padding => 4)
    @bonus = FXTextField.new(@frame_input, 17)

    @fixed_salary.connect(SEL_COMMAND) do
      unless @fixed_salary.text =~ /^\d+$/ || @fixed_salary.text == ''
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Фиксированная зарплата должна быть целым числом'
        )
      end
    end

    @premium_salary.connect(SEL_COMMAND) do
      unless @premium_salary.text =~ /^\d+$/ || @premium_salary.text == ''
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Ежемесячная премия должна быть целым числом'
        )
      end
    end

    @quarterly_award.connect(SEL_COMMAND) do
      unless @quarterly_award.text =~ /^\d+$/ || @quarterly_award.text == ''
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Ежеквартальная премия должна быть целым числом'
        )
      end
    end

    @bonus.connect(SEL_COMMAND) do
      unless @bonus.text =~ /^\d+\.\d+$/ || @bonus.text == ''
        FXMessageBox.warning(
          self,
          MBOX_OK,
          "Ошибка",
          'Бонус длжна быть вещественным числом'
        )
      end
    end

    @button_save = FXButton.new(@frame_input,
                  "Сохранить",
                  :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
                  :width => 150, :height => 30)

    @button_save.connect(SEL_COMMAND) do
      unless @fixed_salary.text =~ /^\d+$/ && (@bonus.text =~ /^\d+$/ || @bonus.text == '') &&
        (@premium_salary.text =~ /^\d+$/ || @premium_salary.text == '') &&
        (@quarterly_award.text =~ /^\d+$/ || @quarterly_award.text == '') && @name_post != ''
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
    @controller_instance.add(@name_post.text, @fixed_salary.text.to_i, @premium_salary.text.to_i,
                             @quarterly_award.text.to_i, @bonus.text.to_f)
    @table.appendRows(1)
    @table.setItemText(@table.numRows - 1, 0, @name_post.text)
    @table.setItemText(@table.numRows - 1, 1, @fixed_salary.text)
    @table.setItemText(@table.numRows - 1, 2, @premium_salary.text)
    @table.setItemText(@table.numRows - 1, 3, @quarterly_award.text)
    @table.setItemText(@table.numRows - 1, 4, @bonus.text)
    @table.visibleRows += 1
    self.close
  end
end