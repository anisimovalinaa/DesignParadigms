require 'fox16'
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
                               :width => 130, :height => 30)
    @button_add.connect(SEL_COMMAND) do
      info = @controller_instance.show_posts.to_s
      # info = info.split("\n")
      FXMessageBox.warning(
        self,
        MBOX_OK,
        "Ошибка",
      @controller_instance.instance_post.to_s
      )
    end

    @button_delete = FXButton.new(@frame2,
                                  "Удалить должность",
                                  :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
                                  :width => 130, :height => 30)
    @button_delete.connect(SEL_COMMAND) do |sender, sel, data|
      delete_instance
    end

    # @button_detailed = FXButton.new(@frame2,
    #                                 "Подробнее об должности",
    #                                 :opts => FRAME_RAISED|FRAME_THICK|LAYOUT_CENTER_Y|LAYOUT_FIX_WIDTH|LAYOUT_FIX_HEIGHT,
    #                                 :width => 130, :height => 30)
    # @button_detailed.connect(SEL_COMMAND) do
    #
    # end
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
      (0..5).each do |c|
        @table.setItemText(r, c, row[c+1])
      end
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
    @controller_instance.instance_post.post_name = @table.getItemText(@table.anchorRow, 0)
    @controller_instance.instance_post.fixed_salary = @table.getItemText(@table.anchorRow, 1).to_i
    @controller_instance.instance_post.fixed_premium = @table.getItemText(@table.anchorRow, 2).to_i
    @controller_instance.instance_post.quarterly_award = @table.getItemText(@table.anchorRow, 3).to_i
    @controller_instance.instance_post.possible_bonus = @table.getItemText(@table.anchorRow, 4).to_i
    @controller_instance.change
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