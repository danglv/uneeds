# TimeFormatHelperModule
module TimeFormatHelperModule
  def format_datetime(date, format)
    return unless date
    I18n.l date, format: format
  end
end
