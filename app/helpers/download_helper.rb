module DownloadHelper

  DOWNLOAD_LABEL_CLASS = {
    all: "label-success",
    low: "label-info",
    none: "label-danger"
  }

  def download_badge(value)
    content_tag(:span, text(value), class: "label #{label_class(value)}")
  end

  def label_class(value)
    DOWNLOAD_LABEL_CLASS.fetch(value.to_sym)
  end

  def text(value)
    I18n.t("download.#{value}.text")
  end

end