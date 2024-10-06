class PreviewController < ApplicationController

  def create
    MakePreviewJob.perform_later(**permitted_params.to_h.symbolize_keys)
  end

  def permitted_params
    params.permit(:attribute_name, :bucket, :callback_url, :file_name, :id, :model_name)
  end
end
