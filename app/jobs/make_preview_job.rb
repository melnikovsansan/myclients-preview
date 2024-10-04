class MakePreviewJob < ApplicationJob
  queue_as :default

  def perform(**options)
    PreviewService.call(**options)
  end
end
