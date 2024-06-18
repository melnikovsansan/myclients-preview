module StringExtension
  extend ActiveSupport::Concern
  def soft_color(color_name)
    respond_to?(color_name) ? public_send(color_name) : self
  end
end

String.include StringExtension
