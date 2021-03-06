require 'fox16'
require_relative '../Controller/Factory_list/controller_employee_list_factory'
require_relative 'window_employee_list'
require_relative 'window_add_post'
include Fox

class Window_department_instance < FXMainWindow
  def initialize(app, instance, controller_instance)
    super(app, "Staff" , :width => 1200, :height => 600)
    @instance = instance
    @controller_instance = controller_instance
    head = FXLabel.new(self, 'Работа отдела кадров', :opts => JUSTIFY_CENTER_X, :padding => 15)
    head.justify = JUSTIFY_CENTER_X
    head.font =  FXFont.new(app, "Geneva" , 15)

    @main_frame = FXHorizontalFrame.new(self)
    @frame1 = FXVerticalFrame.new(@main_frame,
          :opts => LAYOUT_FIX_WIDTH, :width => 900)
    @frame1.borderColor = 'red'

    @frame2 = FXVerticalFrame.new(@main_frame, :padding => 60)

    table_head = FXLabel.new(@frame1, "Таблица должностей. #{@instance.name}", :padding => 10)
    table_head.font = FXFont.new(app, "Geneva", 10)
    @table = FXTable.new(@frame1, :padding => 10, :opts => LAYOUT_FIX_WIDTH, :width => 910)

    show_posts

    @button_add = FXButton.new(@frame2,
                 "Добавить должность",
                 :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
                 :width => 150, :height => 30)
    @button_add.connect(SEL_COMMAND) do
      # @table.setTableSize(0, 0)
      app_add = FXApp.instance
      app_add.create
      w = Window_add_post.new(app_add, @controller_instance, @table)
      w.create
      app_add.run
      app_add.stop
    end

    @button_delete = FXButton.new(@frame2,
              "Удалить должность",
              :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
              :width => 150, :height => 30)
    @button_delete.connect(SEL_COMMAND) { delete_instance }

    @combo_list_emp = FXComboBox.new(@frame2, 30)
    fill_list_emp

    @button_set_emp = FXButton.new(@frame2,
                      "Назначить на должность",
                      :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
                      :width => 150, :height => 30)
    @button_set_emp.connect(SEL_COMMAND) do
      set_emp
    end

    @button_detailed_emp = FXButton.new(@frame2,
                    "Подробнее о сотрудниках",
                    :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
                    :width => 150, :height => 30)
    @button_detailed_emp.connect(SEL_COMMAND) do
      controller_emp = Controller_Employee_List_Factory.new
      controller_emp = controller_emp.create_controller_list
      app_emp = FXApp.instance
      app_emp.create
      w = Window_employee_list.new(app_emp, controller_emp)
      w.create
      app_emp.run
    end

  end

  def set_emp
    @controller_instance.set_emp(@combo_list_emp.text.split(',')[1].lstrip)
    @table.setItemText(@table.anchorRow, 5, @combo_list_emp.text.split(',')[0])
  end

  def fill_list_emp
    list_emp = @controller_instance.get_vacant_emp
    @combo_list_emp.appendItem('Показать всех сотрудников')
    list_emp.each { |emp| @combo_list_emp.appendItem(emp)}
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def show_posts
    names_columns = ['Должность', 'Фиксированная зарплата', 'Ежемесячная премия', 'Ежеквартальная премия', 'Бонусы', 'Сотрудник']
    info = @controller_instance.show_posts.to_s.split("\n")

    @table.setTableSize(info.size, 7)

    @table.rowHeaderMode = LAYOUT_FIX_WIDTH
    @table.rowHeaderWidth = 5

    @table.visibleRows = info.size
    @table.visibleColumns = 5

    names_columns.each_with_index do |name, ind|
      @table.setColumnText(ind, name)
      @table.setColumnWidth(ind, 150)
    end

    # Initialize the scrollable part of the table
    (0..info.size-1).each do |r|
      row = info[r].to_s.split(',')
      (0..4).each do |c|
        @table.setItemText(r, c, row[c+1])
      end
      @table.setItemText(r, 5, row[7])
      @table.setItemText(r, 6, row[0])
    end

    @table.connect(SEL_CLICKED) do
      choose_instance
    end

    @table.connect(SEL_REPLACED) do
      change_instance
    end
  end

  def change_instance
    @controller_instance.change(@table.getItemText(@table.anchorRow, 0).lstrip,
                                @table.getItemText(@table.anchorRow, 1).to_i,
                                @table.getItemText(@table.anchorRow, 2).to_i,
                                @table.getItemText(@table.anchorRow, 3).to_i,
                                @table.getItemText(@table.anchorRow, 4).to_i)
  end

  def choose_instance
    @controller_instance.choose_post(@table.getItemText(@table.anchorRow, 6).to_i)
  end

  def delete_instance
    if @table.anchorRow == -1
      FXMessageBox.warning(
        self,
        MBOX_OK,
        "Ошибка",
        "Не выбрана ячейка"
      )
    else
      @controller_instance.delete
      @table.removeRows(@table.anchorRow)
    end
  end
end