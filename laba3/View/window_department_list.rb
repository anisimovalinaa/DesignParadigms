require 'fox16'
require_relative '../Controller/Factory_list/controller_department_list_factory'
include Fox

class Window_department_list < FXMainWindow
  attr_accessor :hFrame1
  def initialize(app, controller_list)
    @controller_list = controller_list
    super(app, "Staff" , :width => 600, :height => 400)
    @app = app

    head = FXLabel.new(self, 'Работа отдела кадров', :opts => JUSTIFY_CENTER_X, :padding => 15)
    head.justify = JUSTIFY_CENTER_X
    head.font =  FXFont.new(app, "Geneva" , 15)

    @main_frame = FXHorizontalFrame.new(self)
    @frame1 = FXVerticalFrame.new(@main_frame)

    @frame2 = FXVerticalFrame.new(@main_frame, :padding => 60)

    show_dep
    @button_add = FXButton.new(@frame2,
               "Добавить отдел",
               :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
               :width => 130, :height => 30)

    @button_delete = FXButton.new(@frame2,
              "Удалить отдел",
              :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
              :width => 130, :height => 30)
    @button_delete.connect(SEL_COMMAND) do |sender, sel, data|
      delete_instance
    end

    @button_save_change = FXButton.new(@frame2,
              "Сохранить изменения",
              :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
              :width => 130, :height => 30)
    @button_save_cha = FXButton.new(@frame2,
               "Подробнее об отделе",
               :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
               :width => 130, :height => 30)
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def show_dep
    table_head = FXLabel.new(@frame1, 'Таблица отделов', :padding => 10)
    table_head.font = FXFont.new(@app, "Geneva", 10)
    info = @controller_list.show_list.to_s
    info = info.split("\n")

    @table = FXTable.new(@frame1,
             :opts => TABLE_COL_SIZABLE,
             :padding => 10)

    @table.setTableSize(info.size + 1, 2)

    @table.setColumnWidth(1, 150)
    @table.rowHeaderMode = LAYOUT_FIX_WIDTH
    @table.rowHeaderWidth = 5


    @table.visibleRows = info.size + 1
    @table.visibleColumns = 3

    # Initialize the scrollable part of the table
    (0..info.size).each do |r|
      row = info[r].to_s.split('.')
      (0..1).each do |c|
        @table.setItemText(r, c, row[c])
      end
    end

    @table.setColumnText(0, 'Номер отдела')
    @table.setColumnText(1, 'Название отдела')

    @table.connect(SEL_CLICKED) do
      choose_instance
    end

    @table.connect(SEL_REPLACED) do
      change_instance(@table.getItemText(@table.anchorRow, 1))
    end

  end

  def change_instance(name)
    @controller_list.change_instance(name)
  end

  def choose_instance
    @controller_list.choose_instance(@table.getItemText(@table.anchorRow, 0).to_i)
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
      @controller_list.delete_instance
      @table.removeRows(@table.anchorRow)
    end
  end
end