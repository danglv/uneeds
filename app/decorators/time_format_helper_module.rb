# TimeFormatHelperModule
module TimeFormatHelperModule
  def format_datetime(date, format)
    I18n.l date, format: format
  end
end
