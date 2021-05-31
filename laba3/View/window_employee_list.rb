require 'fox16'
include Fox

class Window_employee_list < FXMainWindow
  def initialize(app, controller_emp)
    @app = app
    @controller_emp = controller_emp
    super(app, "Staff" , :width => 1200, :height => 600)

    head = FXLabel.new(self, 'Работа отдела кадров', :opts => JUSTIFY_CENTER_X, :padding => 15)
    head.justify = JUSTIFY_CENTER_X
    head.font =  FXFont.new(app, "Geneva" , 15)

    @main_frame = FXHorizontalFrame.new(self)
    @frame1 = FXVerticalFrame.new(@main_frame,
                                  :opts => LAYOUT_FIX_WIDTH, :width => 900)

    @frame2 = FXVerticalFrame.new(@main_frame, :padding => 60)

    table_head = FXLabel.new(@frame1, "Таблица сотрудников", :padding => 10)
    table_head.font = FXFont.new(app, "Geneva", 10)
    @table = FXTable.new(@frame1, :padding => 10, :opts => LAYOUT_FIX_WIDTH, :width => 910)
    show_emp
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def show_emp
    names_columns = ['Имя', 'Дата рождения', 'Номер телефона', 'Адрес', 'E-mail', 'Паспорт',
                     'Специальность', 'Опыт работы', 'Прошлое место работы', 'Прошлая должность', 'Прошлая зарплата']
    info = @controller_emp.show_list.to_s.split("\n")

    @table.setTableSize(info.size, 12)

    @table.rowHeaderMode = LAYOUT_FIX_WIDTH
    @table.rowHeaderWidth = 5

    @table.visibleRows = info.size
    @table.visibleColumns = 10

    names_columns.each_with_index do |name, ind|
      @table.setColumnText(ind, name)
      @table.setColumnWidth(ind, 150)
    end

    # Initialize the scrollable part of the table
    (0..info.size-1).each do |r|
      row = info[r].to_s.split(',')
      (0..10).each do |c|
        @table.setItemText(r, c, row[c+1])
      end
      @table.setItemText(r, 11, row[0])
    end

    @table.connect(SEL_CLICKED) do
      choose_instance
    end

    @table.connect(SEL_REPLACED) do
      change_instance
    end
  end
end